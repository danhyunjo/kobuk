import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class Violet2Screen extends StatefulWidget {
  const Violet2Screen({Key? key}) : super(key: key);

  @override
  State<Violet2Screen> createState() => _Violet2ScreenState();
}

class _Violet2ScreenState extends State<Violet2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset('assets/images/wave/violet_wave.png',
            width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Image.asset('assets/images/violet/q2/question.png',
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
                  Navigator.pushNamed(context, RouteName.violetQ3);
                },
                child: Image.asset('assets/images/violet/q2/choice1.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.violetQ3);
                },
                child: Image.asset('assets/images/violet/q2/choice2.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.violetQ3);
                },
                child: Image.asset(
                  'assets/images/violet/q2/choice3.png',
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.35,
                )),
          ],
        )
      ]),
    );
  }
}
