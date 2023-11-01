import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Character3Screen extends StatefulWidget {
  const Character3Screen({Key? key}) : super(key: key);

  @override
  State<Character3Screen> createState() => _Character3ScreenState();
}

class _Character3ScreenState extends State<Character3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png'),
            Image.asset('assets/images/character/q3/question.png'),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ3);
                }, child: Image.asset('assets/images/character/q3/choice1.png')),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ3);

                }, child: Image.asset('assets/images/character/q3/choice2.png')),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ3);

                }, child: Image.asset('assets/images/character/q3/choice3.png')),

              ],
            )

          ]
      ),
    );
  }
}

