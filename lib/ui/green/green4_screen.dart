import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Green4Screen extends StatefulWidget {
  const Green4Screen({Key? key}) : super(key: key);

  @override
  State<Green4Screen> createState() => _Green4ScreenState();
}

class _Green4ScreenState extends State<Green4Screen> {
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
        Image.asset('assets/images/green/q4/question.png',
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
                  Navigator.pushNamed(context, RouteName.greenQ5);
                },
                child: Image.asset('assets/images/green/q4/choice1.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ5);
                },
                child: Image.asset('assets/images/green/q4/choice2.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ5);
                },
                child: Image.asset(
                  'assets/images/green/q4/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
