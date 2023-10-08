import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../core/logic/sound_player.dart';

class SightExampleScreen extends StatefulWidget {
  const SightExampleScreen({Key? key}) : super(key: key);

  @override
  State<SightExampleScreen> createState() => _SightExampleScreenState();
}

class _SightExampleScreenState extends State<SightExampleScreen> {
  final String audioPath = 'sounds/sight_exam.mp3';
  final SoundPlayerLogic _logic = SoundPlayerLogic();

  @override
  void initState() {
    super.initState();
    _logic.playSound(audioPath);
  }

  @override
  void dispose(){
    _logic.dispose();
    super.dispose();
  }

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
