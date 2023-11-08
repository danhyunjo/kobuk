import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue4Screen extends StatefulWidget {
  const LightBlue4Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue4Screen> createState() => _LightBlue4ScreenState();
}

class _LightBlue4ScreenState extends State<LightBlue4Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/light_blue_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ㅣ', style: TextStyle(fontSize: 150, fontFamily: 'HY'),)
          ],),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
        Row(children: [
          SizedBox(width: 30,),
          Align(
              alignment: Alignment.bottomLeft,
              child:Image.asset('assets/images/record.png')
          ),
        ],),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, RouteName.lightblueQ5);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
