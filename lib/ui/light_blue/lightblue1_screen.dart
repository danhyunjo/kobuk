import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue1Screen extends StatefulWidget {
  const LightBlue1Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue1Screen> createState() => _LightBlue1ScreenState();
}

class _LightBlue1ScreenState extends State<LightBlue1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/light_blue_wave.png'),
        Stack(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.3),
            Align(
                alignment:Alignment.centerLeft,
                child: const Text('(연습화면)', style: TextStyle(color:Colors.red,fontSize: 24, fontFamily: 'HY'),)),
          ],
        ),Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ㅏ', style: TextStyle(fontSize: 150, fontFamily: 'HY'),)
          ],),

        TextButton(onPressed: (){
          Navigator.pushNamed(context, RouteName.lightblueQ2);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
