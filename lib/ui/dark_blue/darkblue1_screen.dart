import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../core/logic/shared_preference_manager.dart';

class DarkBlue1Screen extends StatefulWidget {
  const DarkBlue1Screen({Key? key}) : super(key: key);

  @override
  State<DarkBlue1Screen> createState() => _DarkBlue1ScreenState();
}

class _DarkBlue1ScreenState extends State<DarkBlue1Screen> {
  Stopwatch _stopwatch = Stopwatch();
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  int questionNumber = 1;
  
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
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Image.asset('assets/images/dark_blue/q1/question.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.darkblueQ2);
                _stopwatch.stop();
                int elapsedTime = _stopwatch.elapsed.inSeconds;
                _prefsManager.saveAnswer(questionNumber, 1, elapsedTime);
                _prefsManager.printAll();
              }, child: Image.asset('assets/images/dark_blue/q1/choice1.png', width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.darkblueQ2);
                _stopwatch.stop();
                int elapsedTime = _stopwatch.elapsed.inSeconds;
                _prefsManager.saveAnswer(questionNumber, 0, elapsedTime);
                _prefsManager.printAll();
              }, child: Image.asset('assets/images/dark_blue/q1/choice2.png', width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.darkblueQ2);
                _stopwatch.stop();
                int elapsedTime = _stopwatch.elapsed.inSeconds;
                _prefsManager.saveAnswer(questionNumber, 0, elapsedTime);
                _prefsManager.printAll();
              }, child: Image.asset('assets/images/dark_blue/q1/choice3.png', width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),

            ],
          )

        ]
      ),
    );
  }
}

