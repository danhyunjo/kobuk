import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../repo/audio_player.dart';
import '../question_view.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final String audioPath = 'sounds/start.mp3';
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
        Stack(
          children: [
          Container(
                child: Image.asset('assets/images/light_blue_box.png'),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/images/start.png', width: MediaQuery.of(context).size.width*0.3,)
                ),
              ),
          ],
        ),
        Image.asset('assets/images/wave/light_blue_wave.png'),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionView(pageNumber:11)));
              _audioLogic.pauseSound();
            },
            child: Icon(Icons.arrow_forward))
      ],
    ));
  }
}
