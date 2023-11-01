import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Character1Screen extends StatefulWidget {
  const Character1Screen({Key? key}) : super(key: key);

  @override
  State<Character1Screen> createState() => _Character1ScreenState();
}

class _Character1ScreenState extends State<Character1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children : [
          Image.asset('assets/images/dark_blue_wave.png'),
          Image.asset('assets/images/character/q1/question.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.characterQ2);
              }, child: Image.asset('assets/images/character/q1/choice1.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.3,)),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.characterQ2);
              }, child: Image.asset('assets/images/character/q1/choice2.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.3,)),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.characterQ2);

              }, child: Image.asset('assets/images/character/q1/choice3.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.3,)),

            ],
          )

        ]
      ),
    );
  }
}

