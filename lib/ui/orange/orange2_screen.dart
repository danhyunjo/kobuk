import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Orange2Screen extends StatefulWidget {
  const Orange2Screen({Key? key}) : super(key: key);

  @override
  State<Orange2Screen> createState() => _Orange2ScreenState();
}

class _Orange2ScreenState extends State<Orange2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/orange_wave.png'),
        SizedBox(height: MediaQuery.of(context).size.height*0.3),
        Image.asset('assets/images/orange/q2/question.png',height: MediaQuery.of(context).size.height*0.3),
        SizedBox(height: MediaQuery.of(context).size.height*0.1),
        Row(children: [
          SizedBox(width: 30,),
          Align(
              alignment: Alignment.bottomLeft,
              child:Image.asset('assets/images/record.png')
          ),
        ],),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, RouteName.child_review);
        }, child: Icon(Icons.add),
        )
      ],),
    );
  }
}
