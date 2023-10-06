import 'package:flutter/cupertino.dart';
import 'package:kobuk/ui/preparation/sight_example_screen.dart';
import '../../ui/start/start_screen.dart';
import '/ui/intro/intro_screen.dart';
import '/ui/preparation/full_example_screen.dart';
import '/ui/preparation/posture_example_screen.dart';
class RouteName {
  static const splash = "/intro";
  static const fullExam = "/fullexam";
  static const sightExam = "/sightexam";
  static const postureExam = "/postureExam";
  static const start = "/start";

}

var namedRoutes = <String, WidgetBuilder>{	// <String, WidgetBuilder> 생략가능
  RouteName.splash: (context) => IntroScreen(),
  RouteName.fullExam: (context) => FullExampleScreen(),
  RouteName.sightExam: (context) => SightExampleScreen(),
  RouteName.postureExam: (context) => PostureExampleScreen(),
  RouteName.start: (context) => StartScreen(),
};