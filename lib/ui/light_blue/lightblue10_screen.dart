import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue10Screen extends StatefulWidget {
  const LightBlue10Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue10Screen> createState() => _LightBlue10ScreenState();
}

class _LightBlue10ScreenState extends State<LightBlue10Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/light_blue_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton(
            child: Image.asset('assets/images/light_blue/q10/choice1.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35,),
            onPressed: (){
              Navigator.pushNamed(context, RouteName.lightblueQ11);
            },
          ),
          TextButton(
            child: Image.asset('assets/images/light_blue/q10/choice2.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
            onPressed: (){
              Navigator.pushNamed(context, RouteName.lightblueQ11);
            },
          ),
        ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TextButton(
                child: Image.asset('assets/images/light_blue/q10/choice3.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
                onPressed: (){
                  Navigator.pushNamed(context, RouteName.lightblueQ11);
                },
              ),
              TextButton(
                child: Image.asset('assets/images/light_blue/q10/choice4.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
                onPressed: (){
                  Navigator.pushNamed(context, RouteName.lightblueQ11);
                },
              ),
            ],)
        ]),
    );
  }
}
