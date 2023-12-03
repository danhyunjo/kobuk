import 'package:flutter/material.dart';

import '../../repo/audio_player.dart';
import '../../core/route/route_name.dart';

class PostureExampleScreen extends StatefulWidget {
  const PostureExampleScreen({Key? key}) : super(key: key);

  @override
  State<PostureExampleScreen> createState() => _PostureExampleScreenState();
}

class _PostureExampleScreenState extends State<PostureExampleScreen> {
  final String audioPath = 'sounds/posture_exam.mp3';
  final SoundPlayer _audioLogic = SoundPlayer();

  @override
  void initState() {
    super.initState();
    _audioLogic.playSound(audioPath);
  }

  @override
  void dispose() {
    _audioLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          'assets/images/wave/light_blue_wave.png',
        ),
        const SizedBox(
          height: 30,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/posture_exam.png',
              height: MediaQuery.of(context).size.height * 0.5),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.sightExam);
                _audioLogic.pauseSound();
              },
              child: Image.asset(
                'assets/images/arrow.png',
                width: MediaQuery.of(context).size.width * 0.1,
              )),
        ])
      ],
    ));
  }
}
