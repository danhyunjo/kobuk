import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Character2Screen extends StatefulWidget {
  const Character2Screen({Key? key}) : super(key: key);

  @override
  State<Character2Screen> createState() => _Character2ScreenState();
}

class _Character2ScreenState extends State<Character2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png'),
            Row(
              children: [
                Image.asset('assets/images/character/q2/question.png'),
                Image.asset('assets/images/character/q2/divider.png'),
                Column(
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.characterQ4);
                    }, child:Image.asset('assets/images/character/q2/choice1.png')),
                    ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.characterQ4);

                    }, child:Image.asset('assets/images/character/q2/choice2.png')),
                    ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.characterQ4);

                    }, child:Image.asset('assets/images/character/q2/choice3.png')),
                  ],
                )
              ],
            )

          ]
      ),
    );
  }
}

