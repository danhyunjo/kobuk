import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          children: [
            Stack(
              children: [
                Positioned(child: Container(child: Image.asset('assets/images/light_blue_box.png'),),),
                Positioned(child: Container(child: Text('준비되었나요?\n누르세요.')))
    ],
            )
            ,
            Image.asset('assets/images/light_blue_wave.png'),
            ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_forward))

          ],
        )
    );
  }
}

