import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobuk/core/logic/asset_setting.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:async/async.dart';
import 'package:kobuk/ui/question_view/template1_screen.dart';
import 'package:kobuk/ui/question_view/template2_screen.dart';
import 'package:video_player/video_player.dart';

//영상 재생 문제
class Template3Screen extends StatefulWidget {
  final int pageNumber;
  const Template3Screen({Key? key, required this.pageNumber}) : super(key: key);

  @override
  State<Template3Screen> createState() => _Template3ScreenState();
}

class _Template3ScreenState extends State<Template3Screen> {

  //화면 전환 컨트롤
  final StreamController<bool> _canSwitchScreenController =
  StreamController<bool>();

  //최대 소요 시간 카운트 할 때 사용되는 컨트롤러
  late Timer timeout;
  int countdown = 0;

  AudioSetting _assetSetting = AudioSetting();

  //비디오 재생에 필요한 컨트롤러
  late VideoPlayerController _videoPlayerController;

  //현재 페이지의 정보와 다음 페이지의 정보(페이지 전환 시 필요함) 저장하는 변수
  var assets;
  var nextAssets;


  @override
  void initState() {
    super.initState();
    setAsset();
  }

  @override
  void dispose() {
    _canSwitchScreenController.close();
    _videoPlayerController.dispose();
    super.dispose();
  }

  //question_assets.json 파일에서 현재 화면과 다음 화면의 정보를 읽어와 변수에 저장하는 함수
  Future<void> setAsset() async {
    String jsonString = await rootBundle.loadString('assets/page_assets.json');
    var data = jsonDecode(jsonString);

    setState(() {
      assets = data['page' + widget.pageNumber.toString()];
      nextAssets = data['page'+(widget.pageNumber+1).toString()];
    });
    print('debug : assets $assets');
    print('debug : call setAudio');

    setVideo(assets['video_path']);

  }

  //비디오를 자동으로 재생하는 함수
  Future<void> setVideo(String videoPath) async {

    _videoPlayerController = VideoPlayerController.asset(
      videoPath,
    )..initialize().then((_) {
        print("Video initialization successful");
        setState(() {
          _videoPlayerController.play();
        });
      });

    //비디오 종료 리스너, 비디오 재생이 끝났을 때 화면 전환을 가능하게 만들고 최대 소요시간 타이머 호출
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        _canSwitchScreenController.add(true);
        print("-----------End video---------------------------");
        setTestScreenSwitcher();
      }
    });
  }

  //선택한 답변을 저장하고, 다음 페이지로 이동
  Future<void> saveAnswer(int selectedAnswer) async{
    //최대 소요시간 측정하는 타이머 취소
    timeout.cancel();

    //실제 소요 시간 측정하는 타이머 종료
    int elapsed_time = await _assetSetting.stopTimer();

    _assetSetting.saveChoiceAnswer(
        assets['question_no'], widget.pageNumber, assets['correct_answer'], selectedAnswer, elapsed_time);

    navigateToTemplateScreen(context, nextAssets['template_no']);

  }

  //최대 소요 시간을 초과하는 동안 아무것도 선택하지 않았다면 선택하지 않았음을 저장하고, 다음 페이지로 이동
  Future<void> setTestScreenSwitcher() async {
    countdown = assets['max_elapsed_time'];

    timeout = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
          print("${widget.pageNumber}:countdown");
          if (countdown == 0) {
            timer.cancel();

            if (assets['question_no'] != -1&&assets['correct_answer'] != -1) {
                saveAnswer(-1);
            } else {
              navigateToTemplateScreen(context, nextAssets['template_no']);

            }
          }
        }
      });
    });
  }

  //_getScreenBuilder 함수를 호출해 리턴값에 해당하는 페이지로 이동
  void navigateToTemplateScreen(BuildContext context, int templateNo) {
    WidgetBuilder? builder = _getScreenBuilder(templateNo);
    if (builder != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
    } else {
      // templateNo에 해당하는 Screen이 없는 경우의 처리
      print("No screen found for templateNo: $templateNo");
    }
  }

  //page_assets.json 파일의 template_no에 해당하는 페이지를 리턴하는 함수
  WidgetBuilder _getScreenBuilder(int templateNo) {
    if ([1, 2, 3, 4, 6, 7, 10].contains(templateNo)) {
      return (context) => Template1Screen(pageNumber: widget.pageNumber + 1);
    } else if ([5, 11].contains(templateNo)) {
      return (context) => Template2Screen(pageNumber: widget.pageNumber + 1);
    } else if ([8, 9].contains(templateNo)) {
      return (context) => Template3Screen(pageNumber: widget.pageNumber + 1);
    } else {
      // 기본 Screen 또는 오류 처리 Screen
      return (context) =>
          Scaffold(
            body: Center(child: Text(
                "No template available for templateNo: $templateNo")),
          );
    }
  }

    @override
  Widget build(BuildContext context) {
      if (assets != null) {
        if (assets['template_no'] == 8) {
          return Scaffold(
              body: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoPlayerController.value.size?.width ?? 0,
                          height: _videoPlayerController.value.size?.height ?? 0,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      ),
                    ),
                    //FURTHER IMPLEMENTATION
                  ],
                ),
              ));
        }
        //문제 카드 부분에 애니메이션 있는 경우
        else if (assets['template_no'] == 9) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(children: [
                Image.asset(assets['wave'],
                    width: MediaQuery.of(context).size.width * 1,
                    fit: BoxFit.cover),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.3,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoPlayerController.value.size?.width ?? 0,
                      height: _videoPlayerController.value.size?.height ?? 0,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<bool>(
                        stream: _canSwitchScreenController.stream,
                        initialData: false,
                        builder: (context, snapshot) {
                          bool canSwitchScreen = snapshot.data ?? false;

                          print("debug: canSwitchScreen $canSwitchScreen");

                          return Row(
                            children: [
                              TextButton(
                                  onPressed: canSwitchScreen
                                      ? () {
                                    // Do something when the button is pressed
                                    saveAnswer(1);
                                  }
                                      : null,
                                  child: Image.asset(
                                    assets['choice1'],
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              TextButton(
                                  onPressed: canSwitchScreen
                                      ? () {
                                    // Do something when the button is pressed
                                    saveAnswer(2);
                                  }
                                      : null,
                                  child: Image.asset(
                                    assets['choice2'],
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              TextButton(
                                  onPressed: canSwitchScreen
                                      ? () {
                                    // Do something when the button is pressed
                                    saveAnswer(3);
                                  }
                                      : null,
                                  child: Image.asset(
                                    assets['choice3'],
                                    height:
                                    MediaQuery.of(context).size.height * 0.2,
                                  ))
                            ],
                          );
                        })
                  ],
                )
              ]),
            ),
          );
        }
        else {
          print('debug : tempalte_no 불일치');
          return Scaffold(
              body: Container(
                  width: MediaQuery.of(context).size.height * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: CircularProgressIndicator()));
        }
      } else {
        print('debug : assets 없음');
        return Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.height * 0.25,
              height: MediaQuery.of(context).size.height * 0.25,
              child: CircularProgressIndicator()),
        );
      }
  }
}
