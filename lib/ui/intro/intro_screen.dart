import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../core/route/route_name.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../core/logic/sound_player.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final String audioPath = 'sounds/intro.mp3';
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
        Text(
            '이 연구는 정부(과학기술정보통신부)의 재원으로 한국연구재단의 지원을 받아  수행하는  ‘ 머신러닝 기반 초등 저학년 문해력 기초 진단도구 개발 입니다.'),
        Text('초등 1학년 문해력 진단 검사'),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.fullExam);
            },
            child: Icon(Icons.arrow_forward)),
        Row(
          children: [
            Image.asset('assets/images/cheongjuuniv.jpg'),
            Column(children: [Text('연구 책임자 한정혜'), Text('공동 연구자 심영택')])
          ],
        )
      ],
    ));
  }
}
