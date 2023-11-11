import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../core/logic/sound_player.dart';
import '../question_view.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final String audioPath = 'sounds/start.mp3';
  final SoundPlayerLogic _logic = SoundPlayerLogic();

  @override
  void initState() {
    super.initState();
    _logic.playSound(audioPath);
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Container(
                child: Image.asset('assets/images/light_blue_box.png'),
              ),
            ),
            Positioned(child: Container(child: Text('준비되었나요?\n누르세요.')))
          ],
        ),
        Image.asset('assets/images/wave/light_blue_wave.png'),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionView(pageNumber: 1)));
            },
            child: Icon(Icons.arrow_forward))
      ],
    ));
  }
}
