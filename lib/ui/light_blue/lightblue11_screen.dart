import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue11Screen extends StatefulWidget {
  const LightBlue11Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue11Screen> createState() => _LightBlue11ScreenState();
}

class _LightBlue11ScreenState extends State<LightBlue11Screen> {
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
              child: Image.asset('assets/images/lightblue/q11/choice1.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35,),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ12);
              },
            ),
            TextButton(
              child: Image.asset('assets/images/lightblue/q11/choice2.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ12);
              },
            ),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Image.asset('assets/images/lightblue/q11/choice3.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ12);
              },
            ),
            TextButton(
              child: Image.asset('assets/images/lightblue/q11/choice4.png',width: MediaQuery.of(context).size.height*0.35, height: MediaQuery.of(context).size.height*0.35),
              onPressed: (){
                Navigator.pushNamed(context, RouteName.lightblueQ12);
              },
            ),
          ],)
      ]),
    );
  }
}
