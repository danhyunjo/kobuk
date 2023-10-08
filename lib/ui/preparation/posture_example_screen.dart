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

