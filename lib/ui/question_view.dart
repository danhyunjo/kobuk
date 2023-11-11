import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:kobuk/ui/review/child_review_screen.dart';

import '../../core/logic/shared_preference_manager.dart';

class QuestionView extends StatefulWidget {
  final int pageNumber;

  const QuestionView({Key? key, required this.pageNumber}) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  Stopwatch _stopwatch = Stopwatch();
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  var assets;

  Future<void> setAsset() async {
    String jsonString = await rootBundle.loadString('assets/page_assets.json');
    var data = jsonDecode(jsonString);
    setState(() {
      assets = data['page' + widget.pageNumber.toString()];
    });
    print('debug : {$assets}');
  }

  @override
  void initState() {
    super.initState();
    setAsset();
    _stopwatch.start();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (assets != null) {
      if (assets['template_no'] == 1) {
        return Scaffold(
          body: Column(children: [
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
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                      _stopwatch.stop();
                      if (assets['question_no'] != -1) {
                        int elapsedTime = _stopwatch.elapsed.inSeconds;
                        _prefsManager.saveAnswer(
                            assets['question_no'], 1, elapsedTime);
                        _prefsManager.printAll();
                      }
                    },
                    child: Image.asset(
                      assets['choice1'],
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                      _stopwatch.stop();
                      if (assets['question_no'] != -1) {
                        int elapsedTime = _stopwatch.elapsed.inSeconds;
                        _prefsManager.saveAnswer(
                            assets['question_no'], 0, elapsedTime);
                        _prefsManager.printAll();
                      }
                    },
                    child: Image.asset(
                      assets['choice2'],
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                      _stopwatch.stop();
                      if (assets['question_no'] != -1) {
                        int elapsedTime = _stopwatch.elapsed.inSeconds;
                        _prefsManager.saveAnswer(
                            assets['question_no'], 0, elapsedTime);
                        _prefsManager.printAll();
                      }
                    },
                    child: Image.asset(
                      assets['choice3'],
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
              ],
            )
          ]),
        );
      } else if (assets['template_no'] == 2) {
        return Scaffold(
          body: Column(children: [
            Image.asset(assets['wave'],
                width: MediaQuery.of(context).size.width * 1,
                fit: BoxFit.cover),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                          _stopwatch.stop();
                          if (assets['question_no'] != -1) {
                            int elapsedTime = _stopwatch.elapsed.inSeconds;
                            _prefsManager.saveAnswer(
                                assets['question_no'], 1, elapsedTime);
                            _prefsManager.printAll();
                          }
                        },
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                          _stopwatch.stop();
                          if (assets['question_no'] != -1) {
                            int elapsedTime = _stopwatch.elapsed.inSeconds;
                            _prefsManager.saveAnswer(
                                assets['question_no'], 0, elapsedTime);
                            _prefsManager.printAll();
                          }
                        },
                        child: Image.asset(
                          assets['choice2'],
                          width: MediaQuery.of(context).size.height * 0.3,
                          height: MediaQuery.of(context).size.height * 0.2,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                          _stopwatch.stop();
                          if (assets['question_no'] != -1) {
                            int elapsedTime = _stopwatch.elapsed.inSeconds;
                            _prefsManager.saveAnswer(
                                assets['question_no'], 0, elapsedTime);
                            _prefsManager.printAll();
                          }
                        },
                        child: Image.asset(
                          assets['choice2'],
                          width: MediaQuery.of(context).size.height * 0.3,
                          height: MediaQuery.of(context).size.height * 0.2,
                        )),
                  ],
                )
              ],
            )
          ]),
        );
      } else if (assets['template_no'] == 3) {
        return Scaffold(
          body: Column(children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                      _stopwatch.stop();
                      if (assets['question_no'] != -1) {
                        int elapsedTime = _stopwatch.elapsed.inSeconds;
                        _prefsManager.saveAnswer(
                            widget.pageNumber, 0, elapsedTime);
                        _prefsManager.printAll();
                      }
                    },
                    child: Image.asset(
                      assets['choice1'],
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                      _stopwatch.stop();
                      if (assets['question_no'] != -1) {
                        int elapsedTime = _stopwatch.elapsed.inSeconds;
                        _prefsManager.saveAnswer(
                            widget.pageNumber, 1, elapsedTime);
                        _prefsManager.printAll();
                      }
                    },
                    child: Image.asset(
                      assets['choice2'],
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                      _stopwatch.stop();
                      if (assets['question_no'] != -1) {
                        int elapsedTime = _stopwatch.elapsed.inSeconds;
                        _prefsManager.saveAnswer(
                            widget.pageNumber, 0, elapsedTime);
                        _prefsManager.printAll();
                      }
                    },
                    child: Image.asset(
                      assets['choice3'],
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
              ],
            )
          ]),
        );
      } else if (assets['template_no'] == 4) {
        return Scaffold(
          body: Column(children: [
            Image.asset(assets['wave'],
                width: MediaQuery.of(context).size.width * 1,
                fit: BoxFit.cover),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                    },
                    child: Image.asset(
                      assets['choice1'],
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                    },
                    child: Image.asset(
                      assets['choice2'],
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionView(
                                  pageNumber: widget.pageNumber + 1)));
                    },
                    child: Image.asset(
                      assets['choice3'],
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                    )),
              ],
            )
          ]),
        );
      } else if (assets['template_no'] == 5) {
        return Scaffold(
          body: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(assets['question'],
                      height: MediaQuery.of(context).size.height * 0.35,
                      fit: BoxFit.fill)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              if (assets['question_no'] != -1)
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset('assets/images/record.png')),
                    TextButton(
                      onPressed: () {
                        if(assets['question_no'] != 30)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                        else {
                          Navigator.pushNamed(context, RouteName.child_review);
                        }
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                )
              else
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionView(
                                pageNumber: widget.pageNumber + 1)));
                  },
                  child: Icon(Icons.add),
                )
            ],
          ),
        );
      } else if (assets['template_no'] == 6) {
        return Scaffold(
          body: Column(children: [
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionView(
                                pageNumber: widget.pageNumber + 1)));
                  },
                ),
                TextButton(
                  child: Image.asset(assets['choice2'],
                      width: MediaQuery.of(context).size.height * 0.35,
                      height: MediaQuery.of(context).size.height * 0.35),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionView(
                                pageNumber: widget.pageNumber + 1)));
                  },
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionView(
                                pageNumber: widget.pageNumber + 1)));
                  },
                ),
                TextButton(
                  child: Image.asset(assets['choice4'],
                      width: MediaQuery.of(context).size.height * 0.35,
                      height: MediaQuery.of(context).size.height * 0.35),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionView(
                                pageNumber: widget.pageNumber + 1)));
                  },
                ),
              ],
            )
          ]),
        );
      } else if (assets['template_no'] == 7) {
        return Scaffold(
          body: Column(children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                        },
                        child: Image.asset(assets['choice1'],
                            width: MediaQuery.of(context).size.height * 0.2,
                            height: MediaQuery.of(context).size.height * 0.2,
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                        },
                        child: Image.asset(assets['choice2'],
                            width: MediaQuery.of(context).size.height * 0.2,
                            height: MediaQuery.of(context).size.height * 0.2,
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionView(
                                      pageNumber: widget.pageNumber + 1)));
                        },
                        child: Image.asset(
                          assets['choice3'],
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                        )),
                    Image.asset(
                      'assets/images/player.png',
                      width: MediaQuery.of(context).size.height * 0.08,
                    )
                  ],
                ),
              ],
            )
          ]),
        );
      } else {
        print('debug : tempalte_no 불일치');
        return Container(
            width: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            child: CircularProgressIndicator());
      }
    } else {
      print('debug : assets 없음');
      return Container(
          width: MediaQuery
              .of(context)
              .size
              .height * 0.25,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.25,
          child: CircularProgressIndicator());
    }
  }
}
