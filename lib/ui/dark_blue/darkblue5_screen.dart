import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class DarkBlue5Screen extends StatefulWidget {
  const DarkBlue5Screen({Key? key}) : super(key: key);

  @override
  State<DarkBlue5Screen> createState() => _DarkBlue5ScreenState();
}

class _DarkBlue5ScreenState extends State<DarkBlue5Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png', width: MediaQuery.of(context).size.width*1,fit: BoxFit.cover),
            SizedBox(height: MediaQuery.of(context).size.height*0.3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.lightblueQ1);
                }, child: Image.asset('assets/images/dark_blue/q4/choice1.png',width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.lightblueQ1);

                }, child: Image.asset('assets/images/dark_blue/q4/choice2.png',width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.lightblueQ1);

                }, child: Image.asset('assets/images/dark_blue/q4/choice3.png',width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),

              ],
            )

          ]
      ),
    );
  }
}

