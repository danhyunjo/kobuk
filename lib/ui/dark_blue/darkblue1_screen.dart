import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class DarkBlue1Screen extends StatefulWidget {
  const DarkBlue1Screen({Key? key}) : super(key: key);

  @override
  State<DarkBlue1Screen> createState() => _DarkBlue1ScreenState();
}

class _DarkBlue1ScreenState extends State<DarkBlue1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children : [
          Image.asset('assets/images/wave/dark_blue_wave.png', width: MediaQuery.of(context).size.width*1,fit: BoxFit.cover),
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Image.asset('assets/images/dark_blue/q1/question.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.darkblueQ2);
              }, child: Image.asset('assets/images/dark_blue/q1/choice1.png', width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.darkblueQ2);
              }, child: Image.asset('assets/images/dark_blue/q1/choice2.png', width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.darkblueQ2);

              }, child: Image.asset('assets/images/dark_blue/q1/choice3.png', width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),

            ],
          )

        ]
      ),
    );
  }
}

