import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stroke_text/stroke_text.dart';
import '../../repo/shared_preference_manager.dart';
import '../../core/route/route_name.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../repo/audio_player.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final String audioPath = 'sounds/intro.mp3';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
            '이 연구는 정부(과학기술정보통신부)의 재원으로 한국연구재단의 지원을 받아  수행하는  ‘ 머신러닝 기반 초등 저학년 문해력 기초 진단도구 개발 입니다.',
            style: TextStyle(color: Colors.black12)),
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StrokeText(
                  text: '초등 1학년',
                  textStyle: TextStyle(fontSize: 44, fontFamily: "HY"),
                  strokeColor: Colors.blueAccent,
                  strokeWidth: 1.2),
              StrokeText(
                  text: '문해력 진단 검사',
                  textStyle: TextStyle(fontSize: 44, fontFamily: "HY"),
                  strokeColor: Colors.blueAccent,
                  strokeWidth: 1.2),
            ],
          ),
        ),
        Expanded(
                child: Stack(
          children: [
            Image.asset('assets/images/wave/light_blue_wave.png'),
            Center(child:
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.fullExam);
                  _audioLogic.pauseSound();
                },
                child: Image.asset(
                  'assets/images/arrow.png',
                )),
            )],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Image.asset('assets/images/cheongjuuniv.png'),
                SizedBox(height: 20)
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            const Column(children: [
              Text(
                '연구 책임자 한정혜',
                style: TextStyle(fontFamily: "HY"),
              ),
              Text('공동 연구자 심영택', style: TextStyle(fontFamily: "HY"))
            ]),
            const SizedBox(
              width: 20,
            ),

          ],
        )
      ],
    ));
  }
}
