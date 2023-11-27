import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../repo/audio_player.dart';

class SightExampleScreen extends StatefulWidget {
  const SightExampleScreen({Key? key}) : super(key: key);

  @override
  State<SightExampleScreen> createState() => _SightExampleScreenState();
}

class _SightExampleScreenState extends State<SightExampleScreen> {
  final String audioPath = 'sounds/sight_exam.mp3';
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
        Image.asset('assets/images/wave/light_blue_wave.png'),
        const SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/sight_exam.png'),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.start);
                  _audioLogic.pauseSound();
                },
                child: Image.asset(
                  'assets/images/arrow.png',
                  width: MediaQuery.of(context).size.width * 0.1,
                )),
          ],
        ),
      ],
    ));
  }
}
