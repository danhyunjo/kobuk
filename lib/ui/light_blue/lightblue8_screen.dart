import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue8Screen extends StatefulWidget {
  const LightBlue8Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue8Screen> createState() => _LightBlue8ScreenState();
}

class _LightBlue8ScreenState extends State<LightBlue8Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/light_blue_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ㅅ', style: TextStyle(fontSize: 150, fontFamily: 'HY'),)
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
          Navigator.pushNamed(context, RouteName.lightblueQ9);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
