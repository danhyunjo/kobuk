import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue5Screen extends StatefulWidget {
  const LightBlue5Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue5Screen> createState() => _LightBlue5ScreenState();
}

class _LightBlue5ScreenState extends State<LightBlue5Screen> {
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
            Text('ㄱ', style: TextStyle(fontSize: 150, fontFamily: 'HY'),)
          ],),

        TextButton(onPressed: (){
          Navigator.pushNamed(context, RouteName.lightblueQ6);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
