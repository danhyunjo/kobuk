import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

class SightExampleScreen extends StatelessWidget {
  const SightExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset('assets/images/light_blue_wave.png'),
        Image.asset('assets/images/sight_exam.png'),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.postureExam);
            },
            child: Icon(Icons.arrow_forward))
      ],
    ));
  }
}
