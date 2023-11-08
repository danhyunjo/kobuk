import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Green7Screen extends StatefulWidget {
  const Green7Screen({Key? key}) : super(key: key);

  @override
  State<Green7Screen> createState() => _Green7ScreenState();
}

class _Green7ScreenState extends State<Green7Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/green_wave.png',
            width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Image.asset('assets/images/green/q7/question.png',
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
                  Navigator.pushNamed(context, RouteName.greenQ8);
                },
                child: Image.asset('assets/images/green/q7/choice1.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ8);
                },
                child: Image.asset('assets/images/green/q7/choice2.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.greenQ8);
                },
                child: Image.asset(
                  'assets/images/green/q7/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
