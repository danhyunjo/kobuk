import 'package:flutter/material.dart';

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
          Image.asset('assets/images/character/q1/question.png'),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Image.asset('assets/images/character/q1/choice1.png')),
              ElevatedButton(onPressed: (){}, child: Image.asset('assets/images/character/q1/choice2.png')),
              ElevatedButton(onPressed: (){}, child: Image.asset('assets/images/character/q1/choice3.png')),

            ],
          )

        ]
      ),
    );
  }
}

