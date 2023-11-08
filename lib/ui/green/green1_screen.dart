import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Green1Screen extends StatefulWidget {
  const Green1Screen({Key? key}) : super(key: key);

  @override
  State<Green1Screen> createState() => _Green1ScreenState();
}

class _Green1ScreenState extends State<Green1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          children : [
            Image.asset('assets/images/wave/green_wave.png', width: MediaQuery.of(context).size.width*1,fit: BoxFit.cover),
            SizedBox(height:MediaQuery.of(context).size.height*0.08),
            Image.asset('assets/images/green/q1/question.png', width: MediaQuery.of(context).size.width*0.3, height: MediaQuery.of(context).size.height*0.25),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.greenQ2);
                    }, child: Image.asset('assets/images/green/q1/choice1.png',width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.cover)),
                  Image.asset('assets/images/player.png', width: MediaQuery.of(context).size.height*0.08,)
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                Column(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.greenQ2);
                    }, child: Image.asset('assets/images/green/q1/choice2.png',width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.cover)),
                    Image.asset('assets/images/player.png', width: MediaQuery.of(context).size.height*0.08,)

                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                Column(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RouteName.greenQ2);
                    }, child: Image.asset('assets/images/green/q1/choice3.png',width: MediaQuery.of(context).size.height*0.2, height: MediaQuery.of(context).size.height*0.2,)),
                    Image.asset('assets/images/player.png', width: MediaQuery.of(context).size.height*0.08,)
                  ],
                ),

              ],
            )

          ]
      ),
    );
  }
}

