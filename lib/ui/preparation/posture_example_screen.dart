import 'package:flutter/material.dart';

import '../../core/logic/sound_player.dart';
import '../../core/route/route_name.dart';

class PostureExampleScreen extends StatefulWidget {
  const PostureExampleScreen({Key? key}) : super(key: key);

  @override
  State<PostureExampleScreen> createState() => _PostureExampleScreenState();
}

class _PostureExampleScreenState extends State<PostureExampleScreen> {
  final String audioPath = 'sounds/posture_exam.mp3';
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
      body:
        Column(
          children: [
            Image.asset('assets/images/wave/light_blue_wave.png',),
            const SizedBox(height: 30,),
            Image.asset('assets/images/posture_exam.png', width: MediaQuery.of(context).size.width * 0.9, height: MediaQuery.of(context).size.height * 0.7),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.sightExam);
                  _audioLogic.pauseSound();
                },
                child: Image.asset(
                  'assets/images/arrow.png',
                  width: MediaQuery.of(context).size.width*0.1,
                )),
          ],
        )
    );
  }
}

