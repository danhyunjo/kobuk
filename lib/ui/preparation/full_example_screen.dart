import 'package:flutter/material.dart';

import '../../core/route/route_name.dart';

class FullExampleScreen extends StatefulWidget {
  const FullExampleScreen({Key? key}) : super(key: key);

  @override
  State<FullExampleScreen> createState() => _FullExampleScreenState();
}

class _FullExampleScreenState extends State<FullExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/light_blue_wave.png'),
          Image.asset('assets/images/full_exam.png'),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.sightExam);
              },
              child: Icon(Icons.arrow_forward))
        ],
      ),
    );
  }
}
