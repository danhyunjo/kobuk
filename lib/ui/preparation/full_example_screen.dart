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
          const SizedBox(height: 30,),
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
