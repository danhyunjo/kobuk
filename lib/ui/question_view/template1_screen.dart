import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobuk/core/logic/asset_setting.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:async/async.dart';
import 'package:kobuk/ui/question_view/template2_screen.dart';
import 'package:kobuk/ui/question_view/template3_screen.dart';
import 'package:video_player/video_player.dart';

//버튼 클릭 문제
class Template1Screen extends StatefulWidget {
  final int pageNumber;
  const Template1Screen({Key? key,required this.pageNumber}) : super(key: key);

  @override
  State<Template1Screen> createState() => _Template1ScreenState();
}

class _Template1ScreenState extends State<Template1Screen> {

  //화면 전환 컨트롤
  final StreamController<bool> _canSwitchScreenController = StreamController<
      bool>();

  AudioSetting _assetSetting = AudioSetting();

  //현재 페이지의 정보와 다음 페이지의 정보(페이지 전환 시 필요함) 저장하는 변수
  var assets;
  var nextAssets;

  //최대 소요 시간 카운트 할 때 사용되는 컨트롤러
  late Timer timeout;
  int countdown = 0;


  @override
  void initState() {
    super.initState();
    setAsset();
  }

  @override
  void dispose() {
    _assetSetting.disposeSound();
    _canSwitchScreenController.close();

    super.dispose();
  }


  //question_assets.json 파일에서 현재 화면과 다음 화면의 정보를 읽어와 변수에 저장하는 함수
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


  //audio를 자동으로 재생하는 함수
  Future<void> setAudio() async {
    List<dynamic> audio_files = assets['audio_files'];
    List<dynamic> audio_delayes = assets['audio_delayes'];

    for (int i = 0; i < audio_files.length; i++) {
      if (i == 0) {
        await _assetSetting.playSound(audio_files[i]);
      } else {
        await _assetSetting.playDelayedSound(
            audio_files[i], audio_delayes[i - 1]);
      }
      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 오디오 종료 리스너");
      });
    }

    //화면 전환 가능하도록 컨트롤러 수정
    _canSwitchScreenController.add(true);

    //최대 소요 시간 타이머 호출
    setTestScreenSwitcher();

    //문제 문항인 경우 소요 시간을 측정하기 위해 타이머 설정
    if (assets['question_no'] != -1 && assets['correct_answer'] != -1) {
      await _assetSetting.setTimer();
    }
  }

  //최대 소요 시간을 초과하는 동안 아무것도 선택하지 않았다면 선택하지 않았음을 저장하고, 다음 페이지로 이동
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
              saveAnswer(-1);
            } else {
              timeout.cancel();
              navigateToTemplateScreen(context, nextAssets['template_no']);
            }
          }
        }
      });
    });
  }

  //선택한 답변을 저장하고, 다음 페이지로 이동
  Future<void> saveAnswer(int selectedAnswer) async{

    //최대 소요시간 측정하는 타이머 취소
    timeout.cancel();

    //실제 소요 시간 측정하는 타이머 종료
    int elapsed_time = await _assetSetting.stopTimer();


    _assetSetting.saveChoiceAnswer(
        assets['question_no'], widget.pageNumber, assets['correct_answer'],
        selectedAnswer, elapsed_time);

    navigateToTemplateScreen(context, nextAssets['template_no']);
  }

  //_getScreenBuilder 함수를 호출해 리턴값에 해당하는 페이지로 이동
  void navigateToTemplateScreen(BuildContext context, int templateNo) {
    WidgetBuilder? builder = _getScreenBuilder(templateNo);
    if (builder != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
    } else {
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
      //문제1 선택지3(가로)
      if (assets['template_no'] == 1) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  fit: BoxFit.cover),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
              ),
              Image.asset(
                assets['question'],
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
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
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.2,
                                )),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
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
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.2,
                                )),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
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
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.2,
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
      //문제1 선택지3(세로)
      else if (assets['template_no'] == 2) {
        return Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(children: [
                Image.asset(assets['wave'],
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    fit: BoxFit.cover),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    assets['question'],
                    width: MediaQuery
                        .of(context)
                        .size
                        .height * 0.45,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                  ),
                  Image.asset(
                    'assets/images/divider.png',
                    width: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.75,
                  ),
                  StreamBuilder<bool>(
                      stream: _canSwitchScreenController.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        bool canSwitchScreen = snapshot.data ?? false;
                        return Column(children: [
                          TextButton(
                              onPressed: canSwitchScreen
                                  ? () {
                                saveAnswer(1);
                              }
                                  : null,
                              child: Image.asset(
                                assets['choice1'],
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.3,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.2,
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                          ),
                          TextButton(
                              onPressed: canSwitchScreen
                                  ? () {
                                saveAnswer(2);
                              }
                                  : null,
                              child: Image.asset(
                                assets['choice2'],
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.3,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.2,
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                          ),
                          TextButton(
                              onPressed: canSwitchScreen
                                  ? () {
                                saveAnswer(3);
                              }
                                  : null,
                              child: Image.asset(
                                assets['choice3'],
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.3,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.2,
                              ))
                        ]);
                      })
                ]),
              ]),
            ));
      }
      //문제1 선택지3(큰문제)
      else if (assets['template_no'] == 3) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  fit: BoxFit.cover),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.08,
              ),
              Image.asset(
                assets['question'],
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.08,
              ),
              StreamBuilder<bool>(
                  stream: _canSwitchScreenController.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool canSwitchScreen = snapshot.data ?? false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(1);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice1'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(2);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice2'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(3);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice3'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                      ],
                    );
                  })
            ]),
          ),
        );
      }
      //선택지3(가로)
      else if (assets['template_no'] == 4) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  fit: BoxFit.cover),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3),
              StreamBuilder<bool>(
                  stream: _canSwitchScreenController.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool canSwitchScreen = snapshot.data ?? false;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(1);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice1'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(2);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice2'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(3);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice3'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                      ],
                    );
                  })
            ]),
          ),
        );
      }
      else if (assets['template_no'] == 6) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: StreamBuilder<bool>(
                stream: _canSwitchScreenController.stream,
                initialData: false,
                builder: (context, snapshot) {
                  bool canSwitchScreen = snapshot.data ?? false;
                  return Column(children: [
                    Image.asset(assets['wave']),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Image.asset(
                            assets['choice1'],
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.35,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.35,
                          ),
                          onPressed: canSwitchScreen
                              ? () {
                            saveAnswer(1);
                          }
                              : null,
                        ),
                        TextButton(
                          child: Image.asset(assets['choice2'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35,
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35),
                          onPressed: canSwitchScreen
                              ? () {
                            saveAnswer(2);
                          }
                              : null,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Image.asset(assets['choice3'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35,
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35),
                          onPressed: canSwitchScreen
                              ? () {
                            saveAnswer(3);
                          }
                              : null,
                        ),
                        TextButton(
                            child: Image.asset(assets['choice4'],
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.35,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.35),
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(4);
                            }
                                : null),
                      ],
                    )
                  ]);
                }),
          ),
        );
      }
      //문제1 선택지3(확성기 아이콘 포함)
      else if (assets['template_no'] == 7) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  fit: BoxFit.cover),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08),
              Image.asset(assets['question'],
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.25),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.15,
              ),
              StreamBuilder<bool>(
                  stream: _canSwitchScreenController.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool canSwitchScreen = snapshot.data ?? false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            TextButton(
                                onPressed: canSwitchScreen
                                    ? () {
                                  saveAnswer(1);
                                }
                                    : null,
                                child: Image.asset(assets['choice1'],
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.1,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.1,
                                    fit: BoxFit.cover)),
                            Image.asset(
                              'assets/images/player.png',
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.08,
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.15,
                        ),
                        Column(
                          children: [
                            TextButton(
                                onPressed: canSwitchScreen
                                    ? () {
                                  saveAnswer(2);
                                }
                                    : null,
                                child: Image.asset(assets['choice2'],
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.1,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.1,
                                    fit: BoxFit.cover)),
                            Image.asset(
                              'assets/images/player.png',
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.08,
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.15,
                        ),
                        Column(
                          children: [
                            TextButton(
                                onPressed: canSwitchScreen
                                    ? () {
                                  saveAnswer(3);
                                }
                                    : null,
                                child: Image.asset(
                                  assets['choice3'],
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.1,
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.1,
                                )),
                            Image.asset(
                              'assets/images/player.png',
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.08,
                            )
                          ],
                        ),
                      ],
                    );
                  })
            ]),
          ),
        );
      }
      //문제3(세로)
      else if (assets['template_no'] == 10) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  fit: BoxFit.cover),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1),
              StreamBuilder<bool>(
                  stream: _canSwitchScreenController.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    bool canSwitchScreen = snapshot.data ?? false;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(1);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice1'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.7,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(2);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice2'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.7,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                              saveAnswer(3);
                            }
                                : null,
                            child: Image.asset(
                              assets['choice3'],
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.7,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                            )),
                      ],
                    );
                  })
            ]),
          ),
        );
      }
      else {
        print('debug : tempalte_no 불일치');
        return Scaffold(
            body: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .height * 0.25,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.25,
                child: CircularProgressIndicator()));
      }
    } else {
      print('debug : assets 없음');
      return Scaffold(
        body: Container(
            width: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            child: CircularProgressIndicator()),
      );
    }
  }
}
