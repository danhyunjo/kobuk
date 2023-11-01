import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Character5Screen extends StatefulWidget {
  const Character5Screen({Key? key}) : super(key: key);

  @override
  State<Character5Screen> createState() => _Character5ScreenState();
}

class _Character5ScreenState extends State<Character5Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png'),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ5);
                }, child: Image.asset('assets/images/character/q5/choice1.png')),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ5);

                }, child: Image.asset('assets/images/character/q5/choice2.png')),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.characterQ5);

                }, child: Image.asset('assets/images/character/q5/choice3.png')),

              ],
            )

          ]
      ),
    );
  }
}

