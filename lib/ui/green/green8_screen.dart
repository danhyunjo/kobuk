import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Green8Screen extends StatefulWidget {
  const Green8Screen({Key? key}) : super(key: key);

  @override
  State<Green8Screen> createState() => _Green8ScreenState();
}

class _Green8ScreenState extends State<Green8Screen> {
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
        Image.asset('assets/images/green/q8/question.png',
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
                  Navigator.pushNamed(context, RouteName.greenQ9);
                },
                child: Image.asset('assets/images/green/q8/choice1.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ9);
                },
                child: Image.asset('assets/images/green/q8/choice2.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ9);
                },
                child: Image.asset(
                  'assets/images/green/q8/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
