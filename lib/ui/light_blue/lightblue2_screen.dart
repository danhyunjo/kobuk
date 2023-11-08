import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class LightBlue2Screen extends StatefulWidget {
  const LightBlue2Screen({Key? key}) : super(key: key);

  @override
  State<LightBlue2Screen> createState() => _LightBlue2ScreenState();
}

class _LightBlue2ScreenState extends State<LightBlue2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/light_blue_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ㅓ', style: TextStyle(fontSize: 150, fontFamily: 'HY'),)
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
          Navigator.pushNamed(context, RouteName.lightblueQ3);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
