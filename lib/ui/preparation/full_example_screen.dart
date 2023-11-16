import 'package:flutter/material.dart';

import '../../core/logic/sound_player.dart';
import '../../core/route/route_name.dart';

class FullExampleScreen extends StatefulWidget {
  const FullExampleScreen({Key? key}) : super(key: key);

  @override
  State<FullExampleScreen> createState() => _FullExampleScreenState();
}

class _FullExampleScreenState extends State<FullExampleScreen> {
  final String audioPath = 'sounds/full_exam.mp3';
  final SoundPlayerLogic _audioLogic = SoundPlayerLogic();

  @override
  void initState() {
    super.initState();
    _audioLogic.playAudio(audioPath);
  }

  @override
  void dispose(){
    _audioLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/wave/light_blue_wave.png'),
          const SizedBox(height: 30,),
          Image.asset('assets/images/full_exam.png'),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.postureExam);
                _audioLogic.pauseSound();
              },
              child: Image.asset(
                'assets/images/arrow.png',
                width: MediaQuery.of(context).size.width*0.1,
              )),
        ],
      ),
    );
  }
}
