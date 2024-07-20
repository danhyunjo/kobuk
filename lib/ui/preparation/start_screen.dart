import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:kobuk/ui/question_view/template1_screen.dart';
import 'package:kobuk/ui/question_view/template2_screen.dart';

import '../../repo/audio_player.dart';
import '../question_view/template3_screen.dart';

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
        ///문제 시작 전 시작 버튼 눌렀을 때 전환되는 화면 지정하는 부분
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Template1Screen(pageNumber: 7)));
              _audioLogic.pauseSound();
            },
            child: Icon(Icons.arrow_forward))
      ],
    ));
  }
}
