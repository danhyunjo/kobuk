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

class _QuestionViewState extends State<QuestionView> with SingleTickerProviderStateMixin{
  final StreamController<bool> _canSwitchScreenController =
      StreamController<bool>();
  final StreamController<bool> _recordingQuestionController =
      StreamController<bool>();
  late VideoPlayerController _videoPlayerController;
  late Timer timeout;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasCompletedPlayback = false;

  // late Timer audioAnimation;
  // double imageSize = 100; // Initial size of the image
  // bool isSmaller =
  //     false; // Flag to track whether the image is currently smaller
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

    // completer.complete();

// if(widget.pageNumber != 19) {
  timeout.cancel();



    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuestionView(pageNumber: widget.pageNumber + 1)));
  }

  Future<void> saveRecord() async {
    // completer.complete();

    // if(timeout != null) {
      timeout.cancel();
    // }        // audioAnimation.cancel();

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

    // Create a curved animation with a smaller interval to control the scaling
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.8, curve: Curves.easeInOut), // Adjust the interval as needed
    );

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);
  }
    // audioAnimation = Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   setState(() {
    //     // Toggle the flag to switch between making the image smaller and restoring its size
    //     isSmaller = !isSmaller;
    //     // Update the size based on the flag
    //     imageSize = isSmaller ? 90.0 : 100.0;
    //   });
    // });


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

  Future<void> setAudio() async {
    List<int> recordQuestions = [7, 8, 9, 11, 12, 13, 14, 35, 36];

    // Set a timeout duration (e.g., 5 seconds)

    if (assets['audio'] != '' &&
        assets['second_audio'] == '' &&
        assets['third_audio'] == '' &&
        assets['fourth_audio'] == '') {
      await _assetSetting.playSound(assets['audio']);

      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 첫번째 오디오 종료 리스너");

        _canSwitchScreenController.add(true);
        _recordingQuestionController.add(true);
      });

      setTestScreenSwitcher();
    } else if (assets['audio'] != '' &&
        assets['second_audio'] != '' &&
        assets['third_audio'] == '' &&
        assets['fourth_audio'] == '') {
      await _assetSetting.playSound(assets['audio']);
      await _assetSetting.listenSoundCompletion();
      await _assetSetting.playDelayedSound(
          assets['second_audio'], assets['delay_time']);

      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 두번째 오디오 종료 리스너");
        _canSwitchScreenController.add(true);
        _recordingQuestionController.add(true);
      });

      setTestScreenSwitcher();
    } else if (assets['audio'] != '' &&
        assets['second_audio'] != '' &&
        assets['third_audio'] != '' &&
        assets['fourth_audio'] == '') {
      await _assetSetting.playSound(assets['audio']);
      await _assetSetting.listenSoundCompletion();
      await _assetSetting.playDelayedSound(
          assets['second_audio'], assets['delay_time']);
      if (assets['question_no'] == -1) {
        _recordingQuestionController.add(true);
      }
      await _assetSetting.listenSoundCompletion();
      await _assetSetting.playDelayedSound(
          assets['third_audio'], assets['second_delay_time']);

      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 세번째 오디오 종료 리스너");
        _canSwitchScreenController.add(true);
        _recordingQuestionController.add(true);
      });

      setTestScreenSwitcher();
    } else if (assets['audio'] != '' &&
        assets['second_audio'] != '' &&
        assets['third_audio'] != '' &&
        assets['fourth_audio'] != '') {
      await _assetSetting.playSound(assets['audio']);
      timeout = Timer(Duration(milliseconds: 100), () {
        print("예비 타이머");
      });
      await _assetSetting.listenSoundCompletion().then((_) async {
        print("debug : 네번째 오디오 종료 리스너");
        _canSwitchScreenController.add(true);
        _recordingQuestionController.add(true);
      });
      await _assetSetting.playDelayedSound(
          assets['second_audio'], assets['delay_time']);
      await _assetSetting.listenSoundCompletion();
      await _assetSetting.playDelayedSound(
          assets['third_audio'], assets['second_delay_time']);
      await _assetSetting.listenSoundCompletion();
      await _assetSetting.playDelayedSound(
          assets['fourth_audio'], assets['third_delay_time']);
      await _assetSetting.listenSoundCompletion();
      await _assetSetting.setPage19Asset();
      await _assetSetting.listenSoundCompletion();


      setTestScreenSwitcher();
    }

    if (recordQuestions.contains(widget.pageNumber)) {
      print("--start animation---");
      startAnimation();
      await _assetSetting.startRecording(assets['question_no']);
    }
    if (assets['question_no'] != -1 && assets['correct_answer'] != -1) {
      await _assetSetting.setTimer();
    }

    print('debug : $assets');
  }


  Future<void> setTestScreenSwitcher() async {
    countdown = assets['max_elapsed_time'];

    timeout = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;

          if (countdown == 0){
            if (assets['question_no'] != -1 && assets['correct_answer'] != -1) {
              saveAnswer(-1);
            } else if (assets['question_no'] != -1 &&
                assets['correct_answer'] == -1) {
              saveRecord();
            }
          }
        } else if (assets['question_no'] == -1) {
          // completer.complete();

          timer.cancel();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      QuestionView(pageNumber: widget.pageNumber + 1)));
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
              color:Colors.white,
              child: Column(children: [
                        Image.asset(assets['wave'],
                width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
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
                                    height:
                                        MediaQuery.of(context).size.height * 0.35,
                                    fit: BoxFit.fill)
                              ],
                            ),
                            if (assets['question_no'] == -1)
                              Text("이것은 연습 화면 입니다",
                                  style: TextStyle(color: Colors.black38, fontSize: MediaQuery.of(context).size.height * 0.05))
                            else
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
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
                                                    fontSize: 30, color: Colors.red)),
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
                                              scale: 1.0 - _animation.value * 0.2, // Adjust the multiplier for the desired effect
                                              child: Image.asset('assets/images/record.png'), // Replace with your image path
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
                                height: MediaQuery.of(context).size.height * 0.35),
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
                              height: MediaQuery.of(context).size.height * 0.35),
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
                              height: MediaQuery.of(context).size.height * 0.35),
                          onPressed: canSwitchScreen
                              ? () {
                                  saveAnswer(3);
                                }
                              : null,
                        ),
                        TextButton(
                            child: Image.asset(assets['choice4'],
                                width: MediaQuery.of(context).size.height * 0.35,
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
                                    width:
                                        MediaQuery.of(context).size.height * 0.2,
                                    height:
                                        MediaQuery.of(context).size.height * 0.2,
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
                                    width:
                                        MediaQuery.of(context).size.height * 0.2,
                                    height:
                                        MediaQuery.of(context).size.height * 0.2,
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
                                  width: MediaQuery.of(context).size.height * 0.2,
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
