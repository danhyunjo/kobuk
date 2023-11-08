import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class DarkBlue2Screen extends StatefulWidget {
  const DarkBlue2Screen({Key? key}) : super(key: key);

  @override
  State<DarkBlue2Screen> createState() => _DarkBlue2ScreenState();
}

class _DarkBlue2ScreenState extends State<DarkBlue2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/dark_blue_wave.png', width: MediaQuery.of(context).size.width*1,fit: BoxFit.cover),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/dark_blue/q2/question.png',width: MediaQuery.of(context).size.height*0.45, height: MediaQuery.of(context).size.height*0.7,),
                Image.asset('assets/images/dark_blue/q2/divider.png',width: MediaQuery.of(context).size.height*0.1, height: MediaQuery.of(context).size.height*0.75,),
                Column(
                  children: [
                    TextButton(
                        onPressed: (){
                      Navigator.pushNamed(context, RouteName.darkblueQ3);
                    }, child:Image.asset('assets/images/dark_blue/q2/choice1.png',
                      width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,),
                    style : ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white))),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.darkblueQ3);

                    }, child:Image.asset('assets/images/dark_blue/q2/choice2.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.darkblueQ3);

                    }, child:Image.asset('assets/images/dark_blue/q2/choice3.png', width: MediaQuery.of(context).size.height*0.3, height: MediaQuery.of(context).size.height*0.2,)),
                  ],
                )
              ],
            )

          ]
      ),
    );
  }
}

