import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue13Screen extends StatefulWidget {
  const LightBlue13Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue13Screen> createState() => _LightBlue13ScreenState();
}

class _LightBlue13ScreenState extends State<LightBlue13Screen> {
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
              child: Image.asset('assets/images/lightblue/q13/choice1.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35,),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
            TextButton(
              child: Image.asset('assets/images/lightblue/q13/choice2.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Image.asset('assets/images/lightblue/q13/choice3.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
            TextButton(
              child: Image.asset('assets/images/lightblue/q13/choice4.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ13);
              },
            ),
          ],)
      ]),
    );
  }
}
