import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobuk/core/logic/asset_setting.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:async/async.dart';
import 'package:video_player/video_player.dart';

class QuestionView extends StatefulWidget {
  final int pageNumber;

  const QuestionView({Key? key, required this.pageNumber}) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView>
    with SingleTickerProviderStateMixin {
  final StreamController<bool> _canSwitchScreenController =
      StreamController<bool>();
  final StreamController<bool> _recordingQuestionController =
      StreamController<bool>();
  late VideoPlayerController _videoPlayerController;
  late Timer timeout;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasCompletedPlayback = false;
  int countdown = 0;

  AudioSetting _assetSetting = AudioSetting();
  var assets;
  bool canSwitchScreen = false;

  void saveAnswer(int selectedAnswer) {
    print(
        "debug : correct_answer = ${assets['correct_answer']}, selectedAnswer = $selectedAnswer");
    _assetSetting.saveChoiceAnswer(
        assets['question_no'], assets['correct_answer'], selectedAnswer);

    print(
        "-------------------------------사용자가 넘김(버튼 클릭으로)-------------------------------");

    timeout.cancel();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuestionView(pageNumber: widget.pageNumber + 1)));
  }

  Future<void> saveRecord() async {
    timeout.cancel();

    if (widget.pageNumber != 36) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  QuestionView(pageNumber: widget.pageNumber + 1)));
      int isRecorded = await _assetSetting.stopRecording(assets['question_no']);

      _assetSetting.saveRecordAnswer(assets['question_no'], isRecorded);
    } else {
      Navigator.pushNamed(context, RouteName.child_review);

      int isRecorded = await _assetSetting.stopRecording(assets['question_no']);

      _assetSetting.saveRecordAnswer(assets['question_no'], isRecorded);
    }
  }

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

  Future<void> setAsset() async {
    List<int> animationVideos = [20, 22, 24, 26, 28, 30];
    String jsonString = await rootBundle.loadString('assets/page_assets.json');
    var data = jsonDecode(jsonString);

    setState(() {
      assets = data['page' + widget.pageNumber.toString()];
    });
    print('debug : assets $assets');
    print('debug : call setAudio');
    if (animationVideos.contains(widget.pageNumber)) {
      setVideo(assets['video_path']);
    } else {
      setAudio();
    }
  }

  void setVideo(String videoPath) {
    _videoPlayerController = VideoPlayerController.asset(
      videoPath,
    )..initialize().then((_) {
        print("Video initialization successful");
        setState(() {});
        _videoPlayerController.play();
      });

    _videoPlayerController.addListener(() {
      if (!_hasCompletedPlayback &&
          _videoPlayerController.value.position ==
              _videoPlayerController.value.duration) {
        // Video playback complete, navigate to the next screen
        _canSwitchScreenController.add(true);
        _hasCompletedPlayback = true;
        print("-----------End video---------------------------");

        setTestScreenSwitcher();
      }
    });
  }

  Future<void> setAudio() async{
    List<int> recordQuestions = [13, 14, 15, 17, 18, 19, 20, 46, 47];
    List<dynamic> audio_files = assets['audio_files'];
    List<dynamic> audio_delayes = assets['audio_delayes'];

    for (int i = 0; i<audio_files.length; i++){
      if(i<audio_delayes.length){
        print("-----1-----");
        print(audio_delayes[i]);
        await _assetSetting.playDelayedSound(audio_files[i],audio_delayes[i]);
      } else {
        print("-----2-----");
        print(audio_files[i]);
        await _assetSetting.playSound(audio_files[i]);
      }
      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 오디오 종료 리스너");
        if(i == audio_files.length-1) {
          _canSwitchScreenController.add(true);
          _recordingQuestionController.add(true);
        }
      });

    }

    setTestScreenSwitcher();


    if (recordQuestions.contains(widget.pageNumber)) {
      print("--start animation---");
      startAnimation();
      await _assetSetting.startRecording(assets['question_no']);
    }
    if (assets['question_no'] != -1 && assets['correct_answer'] != -1) {
      await _assetSetting.setTimer();
    }

  }

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
              if (assets['correct_answer'] != -1) {
                saveAnswer(-1);
              } else if (assets['correct_answer'] == -1) {
                saveRecord();
              }
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          QuestionView(pageNumber: widget.pageNumber + 1)));
            }
          }
        }
      });
    });
  }

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
    _controller.dispose();
    _videoPlayerController.dispose();
    super.dispose();
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
                  width: MediaQuery.of(context).size.width * 1,
                  fit: BoxFit.cover),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset(
                assets['question'],
                height: MediaQuery.of(context).size.height * 0.3,
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
      } //문제1 선택지3(세로)
      else if (assets['template_no'] == 2) {
        return Scaffold(
            body: Container(
          color: Colors.white,
          child: Column(children: [
            Image.asset(assets['wave'],
                width: MediaQuery.of(context).size.width * 1,
                fit: BoxFit.cover),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                assets['question'],
                width: MediaQuery.of(context).size.height * 0.45,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
              Image.asset(
                'assets/images/dark_blue/q2/divider.png',
                width: MediaQuery.of(context).size.height * 0.1,
                height: MediaQuery.of(context).size.height * 0.75,
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
                            width: MediaQuery.of(context).size.height * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextButton(
                          onPressed: canSwitchScreen
                              ? () {
                                  saveAnswer(2);
                                }
                              : null,
                          child: Image.asset(
                            assets['choice2'],
                            width: MediaQuery.of(context).size.height * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextButton(
                          onPressed: canSwitchScreen
                              ? () {
                                  saveAnswer(3);
                                }
                              : null,
                          child: Image.asset(
                            assets['choice3'],
                            width: MediaQuery.of(context).size.height * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                          ))
                    ]);
                  })
            ]),
          ]),
        ));
      } //문제1 선택지3(큰문제)
      else if (assets['template_no'] == 3) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery.of(context).size.width * 1,
                  fit: BoxFit.cover),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Image.asset(
                assets['question'],
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
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
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                                    saveAnswer(2);
                                  }
                                : null,
                            child: Image.asset(
                              assets['choice2'],
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                                    saveAnswer(3);
                                  }
                                : null,
                            child: Image.asset(
                              assets['choice3'],
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            )),
                      ],
                    );
                  })
            ]),
          ),
        );
      } //선택지3
      else if (assets['template_no'] == 4) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery.of(context).size.width * 1,
                  fit: BoxFit.cover),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
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
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                                    saveAnswer(2);
                                  }
                                : null,
                            child: Image.asset(
                              assets['choice2'],
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        TextButton(
                            onPressed: canSwitchScreen
                                ? () {
                                    saveAnswer(3);
                                  }
                                : null,
                            child: Image.asset(
                              assets['choice3'],
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            )),
                      ],
                    );
                  })
            ]),
          ),
        );
      } //녹음문제
      else if (assets['template_no'] == 5) {
        return Scaffold(
          body: Container(
            color:
                assets['question_no'] == -1 ? Colors.lightGreen : Colors.white,
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
      } //선택지4
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Image.asset(
                            assets['choice1'],
                            width: MediaQuery.of(context).size.height * 0.35,
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          onPressed: canSwitchScreen
                              ? () {
                                  saveAnswer(1);
                                }
                              : null,
                        ),
                        TextButton(
                          child: Image.asset(assets['choice2'],
                              width: MediaQuery.of(context).size.height * 0.35,
                              height:
                                  MediaQuery.of(context).size.height * 0.35),
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
                              width: MediaQuery.of(context).size.height * 0.35,
                              height:
                                  MediaQuery.of(context).size.height * 0.35),
                          onPressed: canSwitchScreen
                              ? () {
                                  saveAnswer(3);
                                }
                              : null,
                        ),
                        TextButton(
                            child: Image.asset(assets['choice4'],
                                width:
                                    MediaQuery.of(context).size.height * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.35),
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
      } //문제1 선택지3(확성기 아이콘 포함)
      else if (assets['template_no'] == 7) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(assets['wave'],
                  width: MediaQuery.of(context).size.width * 1,
                  fit: BoxFit.cover),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Image.asset(assets['question'],
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.25),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
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
                                    width: MediaQuery.of(context).size.height *
                                        0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    fit: BoxFit.cover)),
                            Image.asset(
                              'assets/images/player.png',
                              width: MediaQuery.of(context).size.height * 0.08,
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
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
                                    width: MediaQuery.of(context).size.height *
                                        0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    fit: BoxFit.cover)),
                            Image.asset(
                              'assets/images/player.png',
                              width: MediaQuery.of(context).size.height * 0.08,
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
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
                                      MediaQuery.of(context).size.height * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                )),
                            Image.asset(
                              'assets/images/player.png',
                              width: MediaQuery.of(context).size.height * 0.08,
                            )
                          ],
                        ),
                      ],
                    );
                  })
            ]),
          ),
        );
      } else if (assets['template_no'] == 8) {
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
      } else if (assets['template_no'] == 9) {
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
              if (widget.pageNumber == 28)
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
                )
              else if (widget.pageNumber == 30)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.6,
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
      } else {
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
