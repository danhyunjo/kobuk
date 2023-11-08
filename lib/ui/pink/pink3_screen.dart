import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Pink3Screen extends StatefulWidget {
  const Pink3Screen({Key? key}) : super(key: key);

  @override
  State<Pink3Screen> createState() => _Pink3ScreenState();
}

class _Pink3ScreenState extends State<Pink3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/pink_wave.png',
            width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Image.asset('assets/images/pink/q3/question.png',
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.25),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pinkQ4);
                },
                child: Image.asset('assets/images/pink/q3/choice1.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pinkQ4);
                },
                child: Image.asset('assets/images/pink/q3/choice2.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pinkQ4);
                },
                child: Image.asset(
                  'assets/images/pink/q3/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
