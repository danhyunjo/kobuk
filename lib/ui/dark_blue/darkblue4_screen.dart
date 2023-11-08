import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class DarkBlue4Screen extends StatefulWidget {
  const DarkBlue4Screen({Key? key}) : super(key: key);

  @override
  State<DarkBlue4Screen> createState() => _DarkBlue4ScreenState();
}

class _DarkBlue4ScreenState extends State<DarkBlue4Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png', width: MediaQuery.of(context).size.width*1,fit: BoxFit.cover),
            SizedBox(height:MediaQuery.of(context).size.height*0.08),
            Image.asset('assets/images/dark_blue/q4/question.png', width: MediaQuery.of(context).size.width*0.3, height: MediaQuery.of(context).size.height*0.25),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.darkblueQ5);
                }, child: Image.asset('assets/images/dark_blue/q4/choice1.png',width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.cover)),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.darkblueQ5);

                }, child: Image.asset('assets/images/dark_blue/q4/choice2.png',width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.cover)),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.darkblueQ5);
                }, child: Image.asset('assets/images/dark_blue/q4/choice3.png',width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),

              ],
            )

          ]
      ),
    );
  }
}

