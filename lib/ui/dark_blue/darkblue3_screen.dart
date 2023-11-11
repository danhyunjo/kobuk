import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../core/logic/shared_preference_manager.dart';

class DarkBlue3Screen extends StatefulWidget {
  const DarkBlue3Screen({Key? key}) : super(key: key);

  @override
  State<DarkBlue3Screen> createState() => _DarkBlue3ScreenState();
}

class _DarkBlue3ScreenState extends State<DarkBlue3Screen> {
  Stopwatch _stopwatch = Stopwatch();
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  int questionNumber = 3;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/wave/dark_blue_wave.png', width: MediaQuery.of(context).size.width*1,fit: BoxFit.cover),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            Image.asset('assets/images/dark_blue/q3/question.png',width: MediaQuery.of(context).size.width* 0.8, height: MediaQuery.of(context).size.height*0.3,),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.darkblueQ4);
                  _stopwatch.stop();
                  int elapsedTime = _stopwatch.elapsed.inSeconds;
                  _prefsManager.saveAnswer(questionNumber, 0, elapsedTime);
                  _prefsManager.printAll();
                }, child: Image.asset('assets/images/dark_blue/q3/choice1.png',width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.darkblueQ4);
                  _stopwatch.stop();
                  int elapsedTime = _stopwatch.elapsed.inSeconds;
                  _prefsManager.saveAnswer(questionNumber, 1, elapsedTime);
                  _prefsManager.printAll();
                }, child: Image.asset('assets/images/dark_blue/q3/choice2.png',width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.darkblueQ4);
                  _stopwatch.stop();
                  int elapsedTime = _stopwatch.elapsed.inSeconds;
                  _prefsManager.saveAnswer(questionNumber, 0, elapsedTime);
                  _prefsManager.printAll();
                }, child: Image.asset('assets/images/dark_blue/q3/choice3.png',width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),

              ],
            )

          ]
      ),
    );
  }
}

