import 'package:flutter/cupertino.dart';
import 'package:kobuk/ui/preparation/sight_example_screen.dart';
import '../../ui/character_form/character1_screen.dart';
import '../../ui/start/start_screen.dart';
import '/ui/intro/intro_screen.dart';
import '/ui/preparation/full_example_screen.dart';
import '/ui/preparation/posture_example_screen.dart';
class RouteName {
  static const splash = "/intro";
  static const fullExam = "/fullexam";
  static const sightExam = "/sightexam";
  static const postureExam = "/postureexam";
  static const start = "/start";
  static const characterQ1 = "/characterq1";
  static const characterQ2 = "/characterq2";
  static const characterQ3 = "/characterq3";
  static const characterQ4 = "/characterq4";
  static const characterQ5 = "/characterq5";

}

var namedRoutes = <String, WidgetBuilder>{	// <String, WidgetBuilder> 생략가능
  RouteName.splash: (context) => IntroScreen(),
  RouteName.fullExam: (context) => FullExampleScreen(),
  RouteName.sightExam: (context) => SightExampleScreen(),
  RouteName.postureExam: (context) => PostureExampleScreen(),
  RouteName.start: (context) => StartScreen(),
  RouteName.characterQ1: (context) => Character1Screen(),
  // RouteName.characterQ2: (context) => Character2Screen(),
  // RouteName.characterQ3: (context) => Character3Screen(),
  // RouteName.characterQ4: (context) => Character4Screen(),
  // RouteName.characterQ5: (context) => Character5Screen(),
};