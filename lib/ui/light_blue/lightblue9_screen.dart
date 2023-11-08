import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue9Screen extends StatefulWidget {
  const LightBlue9Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue9Screen> createState() => _LightBlue9ScreenState();
}

class _LightBlue9ScreenState extends State<LightBlue9Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/light_blue_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ㅇ', style: TextStyle(fontSize: 150, fontFamily: 'HY'),)
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
          Navigator.pushNamed(context, RouteName.lightblueQ10);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
