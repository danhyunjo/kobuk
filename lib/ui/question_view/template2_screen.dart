import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobuk/core/logic/asset_setting.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:async/async.dart';
import 'package:kobuk/ui/question_view/template1_screen.dart';
import 'package:kobuk/ui/question_view/template3_screen.dart';
import 'package:video_player/video_player.dart';

///녹음 문제
class Template2Screen extends StatefulWidget {
  final int pageNumber;
  const Template2Screen({Key? key, required this.pageNumber}) : super(key: key);

  @override
  State<Template2Screen> createState() => _Template2ScreenState();
}

class _Template2ScreenState extends State<Template2Screen> with SingleTickerProviderStateMixin {

  ///화면 전환 컨트롤
  final StreamController<bool> _canSwitchScreenController =
  StreamController<bool>();
  ///화면에 문제 띄우는 타이밍 컨트롤
  final StreamController<bool> _recordingQuestionController =
  StreamController<bool>();


  AudioSetting _assetSetting = AudioSetting();

  ///애니메이션에 사용되는 컨트롤러
  late AnimationController _controller;
  late Animation<double> _animation;

  ///최대 소요 시간 카운트 할 때 사용되는 컨트롤러
  int countdown = 0;
  late Timer timeout;

  ///현재 페이지의 정보와 다음 페이지의 정보(페이지 전환 시 필요함) 저장하는 변수
  var assets;
  var nextAssets;


  @override
  void initState() {
    super.initState();
    setAsset();
  }

  @override
  void dispose() {
    _assetSetting.disposeSound();
    _assetSetting.disposeRecorder();
    _canSwitchScreenController.close();
    _recordingQuestionController.close();
    _controller.dispose();

    super.dispose();
  }

  ///question_assets.json 파일에서 현재 화면과 다음 화면의 정보를 읽어와 변수에 저장하는 함수
  Future<void> setAsset() async {
    String jsonString = await rootBundle.loadString('assets/page_assets.json');
    var data = jsonDecode(jsonString);

    setState(() {
      assets = data['page' + widget.pageNumber.toString()];
      nextAssets = data['page' + (widget.pageNumber + 1).toString()];

    });
    print('debug : assets $assets');
    print('debug : call setAudio');

    setAudio();

  }

  ///마이크 이미지 애니메이션 동작에 필요한 함수
  void startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.8,
          curve: Curves.easeInOut), // Adjust the interval as needed
    );

    _controller.repeat(reverse: true);
  }

  ///오디오를 자동으로 재생하는 함수
  ///오디오 재생 완료와 화면에 문제 띄우는 타이밍때문에 녹음 연습 문항과 녹음 문제 문항 페이지 이름을 따로 저장
  Future<void> setAudio() async {
    List<int> recordQuestions = [13, 14, 15, 17, 18, 19, 20, 46, 47];
    List<int> recordExamples = [12,16];
    List<dynamic> audio_files = assets['audio_files'];
    List<dynamic> audio_delayes = assets['audio_delayes'];


    //page_assets.json파일에서 가져온 오디오 파일 경로와 오디오 재생 간격 읽어와 오디오 재생
    for (int i = 0; i < audio_files.length; i++) {
      if (i == 0) {
        await _assetSetting.playSound(audio_files[i]);
      } else {
        await _assetSetting.playDelayedSound(audio_files[i], audio_delayes[i-1]);
      }
      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 오디오 종료 리스너");

        //녹음 연습 문항인 경우 두번째 음성 파일 재생이 끝나고 나면 화면에 문제가 나와야 함
        if (recordExamples.contains(widget.pageNumber) && i == 1) {
          _recordingQuestionController.add(true);
        }
      });
    }
    //화면 전환 가능하도록 컨트롤러 수정
    _canSwitchScreenController.add(true);
    //최대 소요 시간 타이머 호출
    setTestScreenSwitcher();

    //녹음 문제 문항인 경우 음성이 모두 끝나고 나서 마이크 이미지 애니메이션
    //화면에 문제 이미지 나오고, 마이크 이미지 애니메이션 시작, 음성 녹음 시작
    if (recordQuestions.contains(widget.pageNumber)) {
      startAnimation();
      _recordingQuestionController.add(true);
      await _assetSetting.startRecording(widget.pageNumber);
    }

  }

  ///최대 소요 시간을 초과하면 녹음된 오디오를 저장하고, 다음 페이지로 이동
  Future<void> setTestScreenSwitcher() async {
    countdown = assets['max_elapsed_time'];

    timeout = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
          print(countdown);
          if (countdown == 0) {
            timer.cancel();
            if (assets['question_no'] != -1) {
              saveRecord();
            } else {
              timeout.cancel();
              navigateToTemplateScreen(context, nextAssets['template_no']);
            }
          }
        }
      });
    });
  }

  ///녹음된 음성 파일을 저장하고, 다음 화면으로 이동하는 함수
  Future<void> saveRecord() async {
    timeout.cancel();

    //녹음된 음성 파일 저장
    int isRecorded = await _assetSetting.stopRecording(widget.pageNumber);
    _assetSetting.saveRecordAnswer(assets['question_no'], widget.pageNumber, isRecorded);


    //현재 page_assets.json 파일에서 맨 마지막 문항 페이지 번호가 47
    //현재 페이지 번호가 47이라면 childReview 화면으로 이동
    if (widget.pageNumber != 47) {
      navigateToTemplateScreen(context, nextAssets['template_no']);
    } else {
      Navigator.pushNamed(context, RouteName.child_review);
    }
  }


  ///_getScreenBuilder 함수를 호출해 리턴값에 해당하는 페이지로 이동
void navigateToTemplateScreen(BuildContext context, int templateNo) {
  WidgetBuilder? builder = _getScreenBuilder(templateNo);
  if (builder != null) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
  } else {
    // templateNo에 해당하는 Screen이 없는 경우의 처리
    print("No screen found for templateNo: $templateNo");
  }
}

///page_assets.json 파일의 template_no에 해당하는 페이지를 리턴하는 함수
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
      if (assets['template_no'] == 5) {
        return Scaffold(
          body: Container(
            color:
            assets['question_no'] == -1 ? const Color(0xff92d050) : Colors.white,
            child: Column(
              children: [
                Image.asset(assets['wave']),
                Stack(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    if (assets['question_no'] == -1)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '(연습화면)',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 24,
                                fontFamily: 'HY'),
                          )),
                  ],
                ),
                StreamBuilder<bool>(
                    stream: _recordingQuestionController.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      bool recordingQuestion = snapshot.data ?? false;
                      if (recordingQuestion)
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(assets['question'],
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    fit: BoxFit.fill)
                              ],
                            ),
                            if (assets['question_no'] == -1)
                              Text("이것은 연습 화면 입니다",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.05))
                            else
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                              ),
                            if (assets['question_no'] != -1)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              '$countdown',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Center(
                                            child: Text('말하세요',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Center(
                                        child: AnimatedBuilder(
                                          animation: _animation,
                                          builder: (context, child) {
                                            // Use a Transform widget to scale the image with the center as the pivot point
                                            return Transform.scale(
                                              scale:
                                              1.0 - _animation.value * 0.2,
                                              // Adjust the multiplier for the desired effect
                                              child: Image.asset(
                                                  'assets/images/record.png'), // Replace with your image path
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                          ],
                        );
                      else
                        return Column(
                          children: [
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.35),
                          ],
                        );
                    }),
              ],
            ),
          ),
        );
      }
      else if (assets['template_no'] == 11) {
        return Scaffold(
          body: Container(
            color:
            assets['question_no'] == -1 ? Colors.lightGreen : Colors.white,
            child: Column(
              children: [
                Image.asset(assets['wave']),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),


                StreamBuilder<bool>(
                    stream: _recordingQuestionController.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      bool recordingQuestion = snapshot.data ?? false;
                      if (recordingQuestion)
                        return Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(assets['question'],
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    fit: BoxFit.fill)
                              ],
                            ),
                            Positioned(
                              bottom : 0,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              '$countdown',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Center(
                                            child: Text('말하세요',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Center(
                                        child: AnimatedBuilder(
                                          animation: _animation,
                                          builder: (context, child) {
                                            return Transform.scale(
                                              scale:
                                              1.0 - _animation.value * 0.2,
                                              child: Image.asset(
                                                  'assets/images/record.png'),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      else
                        return Column(
                          children: [
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.1),
                          ],
                        );
                    }),
              ],
            ),
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
