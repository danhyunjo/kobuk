import 'package:flutter/cupertino.dart';
import 'package:kobuk/ui/preparation/sight_example_screen.dart';
import '../../ui/dark_blue/darkblue1_screen.dart';
import '../../ui/dark_blue/darkblue2_screen.dart';
import '../../ui/dark_blue/darkblue3_screen.dart';
import '../../ui/dark_blue/darkblue4_screen.dart';
import '../../ui/dark_blue/darkblue5_screen.dart';
import '../../ui/start/start_screen.dart';
import '/ui/intro/intro_screen.dart';
import '/ui/preparation/full_example_screen.dart';
import '/ui/preparation/posture_example_screen.dart';
// import '/ui/prep';
import '/ui/light_blue/lightblue1_screen.dart';
import '/ui/light_blue/lightblue2_screen.dart';
import '/ui/light_blue/lightblue3_screen.dart';
import '/ui/light_blue/lightblue4_screen.dart';
import '/ui/light_blue/lightblue5_screen.dart';
import '/ui/light_blue/lightblue6_screen.dart';
import '/ui/light_blue/lightblue7_screen.dart';
import '/ui/light_blue/lightblue8_screen.dart';
import '/ui/light_blue/lightblue9_screen.dart';
import '/ui/light_blue/lightblue10_screen.dart';
import '/ui/light_blue/lightblue11_screen.dart';
import '/ui/light_blue/lightblue12_screen.dart';
import '/ui/light_blue/lightblue13_screen.dart';



class RouteName {
  static const splash = "/intro";
  static const fullExam = "/fullexam";
  static const sightExam = "/sightexam";
  static const postureExam = "/postureexam";
  static const start = "/start";

  static const darkblueQ1 = "/darkblueq1";
  static const darkblueQ2 = "/darkblueq2";
  static const darkblueQ3 = "/darkblueq3";
  static const darkblueQ4 = "/darkblueq4";
  static const darkblueQ5 = "/darkblueq5";

  static const lightblueQ1 = "/lightblueq1";
  static const lightblueQ2 = "/lightblueq2";
  static const lightblueQ3 = "/lightblueq3";
  static const lightblueQ4 = "/lightblueq4";
  static const lightblueQ5 = "/lightblueq5";
  static const lightblueQ6 = "/lightblueq6";
  static const lightblueQ7 = "/lightblueq7";
  static const lightblueQ8 = "/lightblueq8";
  static const lightblueQ9 = "/lightblueq9";
  static const lightblueQ10 = "/lightblueq10";
  static const lightblueQ11 = "/lightblueq11";
  static const lightblueQ12 = "/lightblueq12";
  static const lightblueQ13 = "/lightblueq13";


}

var namedRoutes = <String, WidgetBuilder>{	// <String, WidgetBuilder> 생략가능
  RouteName.splash: (context) => IntroScreen(),
  RouteName.fullExam: (context) => FullExampleScreen(),
  RouteName.sightExam: (context) => SightExampleScreen(),
  RouteName.postureExam: (context) => PostureExampleScreen(),
  RouteName.start: (context) => StartScreen(),
  RouteName.darkblueQ1: (context) => DarkBlue1Screen(),
  RouteName.darkblueQ2: (context) => DarkBlue2Screen(),
  RouteName.darkblueQ3: (context) => DarkBlue3Screen(),
  RouteName.darkblueQ4: (context) => DarkBlue4Screen(),
  RouteName.darkblueQ5: (context) => DarkBlue5Screen(),
  RouteName.lightblueQ1: (context) => LightBlue1Screen(),
  RouteName.lightblueQ2: (context) => LightBlue2Screen(),
  RouteName.lightblueQ3: (context) => LightBlue3Screen(),
  RouteName.lightblueQ4: (context) => LightBlue4Screen(),
  RouteName.lightblueQ5: (context) => LightBlue5Screen(),
  RouteName.lightblueQ6: (context) => LightBlue6Screen(),
  RouteName.lightblueQ7: (context) => LightBlue7Screen(),
  RouteName.lightblueQ8: (context) => LightBlue8Screen(),
  RouteName.lightblueQ9: (context) => LightBlue9Screen(),
  RouteName.lightblueQ10: (context) => LightBlue10Screen(),
  RouteName.lightblueQ11: (context) => LightBlue11Screen(),
  RouteName.lightblueQ12: (context) => LightBlue12Screen(),
  RouteName.lightblueQ13: (context) => LightBlue13Screen(),
};