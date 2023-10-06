import 'package:flutter/material.dart';

import '../../core/route/route_name.dart';

class PostureExampleScreen extends StatelessWidget {
  const PostureExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          children: [
            Image.asset('assets/images/light_blue_wave.png'),
            Image.asset('assets/images/posture_exam.png'),
            ElevatedButton(onPressed: () {Navigator.pushNamed(context, RouteName.start);}, child:
            Icon(Icons.arrow_forward))
          ],
        )
    );
  }
}

