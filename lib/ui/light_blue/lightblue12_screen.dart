import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue12Screen extends StatefulWidget {
  const LightBlue12Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue12Screen> createState() => _LightBlue12ScreenState();
}

class _LightBlue12ScreenState extends State<LightBlue12Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/light_blue_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Image.asset('assets/images/lightblue/q12/choice1.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35,),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
            TextButton(
              child: Image.asset('assets/images/lightblue/q12/choice2.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Image.asset('assets/images/lightblue/q12/choice3.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
            TextButton(
              child: Image.asset('assets/images/lightblue/q12/choice4.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
          ],)
      ]),
    );
  }
}
