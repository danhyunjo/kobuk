import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Green2Screen extends StatefulWidget {
  const Green2Screen({Key? key}) : super(key: key);

  @override
  State<Green2Screen> createState() => _Green2ScreenState();
}

class _Green2ScreenState extends State<Green2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/green_wave.png',
            width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
        Stack(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Align(
                alignment:Alignment.centerLeft,
                child: const Text('(연습화면)', style: TextStyle(color:Colors.red,fontSize: 24, fontFamily: 'HY'),)),],),
        Image.asset('assets/images/green/q2/question.png',
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.25),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ3);
                },
                child: Image.asset('assets/images/green/q2/choice1.png',
                    width: MediaQuery.of(context).size.height * 0.35,
                    height: MediaQuery.of(context).size.height * 0.35,
                    )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ3);
                },
                child: Image.asset('assets/images/green/q2/choice2.png',
                    width: MediaQuery.of(context).size.height * 0.35,
                    height: MediaQuery.of(context).size.height * 0.35,
                    )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ3);
                },
                child: Image.asset(
                  'assets/images/green/q2/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
