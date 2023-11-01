import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Character4Screen extends StatefulWidget {
  const Character4Screen({Key? key}) : super(key: key);

  @override
  State<Character4Screen> createState() => _Character4ScreenState();
}

class _Character4ScreenState extends State<Character4Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png'),
            Image.asset('assets/images/character/q4/question.png'),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ4);
                }, child: Image.asset('assets/images/character/q4/choice1.png')),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ4);

                }, child: Image.asset('assets/images/character/q4/choice2.png')),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ4);

                }, child: Image.asset('assets/images/character/q4/choice3.png')),

              ],
            )

          ]
      ),
    );
  }
}

