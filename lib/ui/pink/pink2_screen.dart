import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Pink2Screen extends StatefulWidget {
  const Pink2Screen({Key? key}) : super(key: key);

  @override
  State<Pink2Screen> createState() => _Pink2ScreenState();
}

class _Pink2ScreenState extends State<Pink2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/pink_wave.png',
            width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Image.asset('assets/images/pink/q2/question.png',
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.4),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.08,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pinkQ3);
                },
                child: Image.asset('assets/images/pink/q2/choice1.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pinkQ3);
                },
                child: Image.asset('assets/images/pink/q2/choice2.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pinkQ3);
                },
                child: Image.asset(
                  'assets/images/pink/q2/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
