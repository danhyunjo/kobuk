import 'package:flutter/cupertino.dart';
import 'package:kobuk/ui/preparation/sight_example_screen.dart';
import '../../ui/dark_blue/darkblue1_screen.dart';
import '../../ui/dark_blue/darkblue2_screen.dart';
import '../../ui/dark_blue/darkblue3_screen.dart';
import '../../ui/dark_blue/darkblue4_screen.dart';
import '../../ui/dark_blue/darkblue5_screen.dart';
import '../../ui/preparation/start_screen.dart';
import '../../ui/preparation/intro_screen.dart';
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
import '/ui/green/green1_screen.dart';
import '/ui/green/green2_screen.dart';
import '/ui/green/green3_screen.dart';
import '/ui/green/green4_screen.dart';
import '/ui/green/green5_screen.dart';
import '/ui/green/green6_screen.dart';
import '/ui/green/green7_screen.dart';
import '/ui/green/green8_screen.dart';
import '/ui/green/green9_screen.dart';
import '/ui/violet/violet1_screen.dart';
import '/ui/violet/violet2_screen.dart';
import '/ui/violet/violet3_screen.dart';
import '/ui/pink/pink1_screen.dart';
import '/ui/pink/pink2_screen.dart';
import '/ui/pink/pink3_screen.dart';
import '/ui/pink/pink4_screen.dart';
import '/ui/orange/orange1_screen.dart';
import '/ui/orange/orange2_screen.dart';
import '/ui/review/child_review_screen.dart';
import '/ui/question_view.dart';




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

  static const greenQ1 = "/greenq1";
  static const greenQ2 = "/greenq2";
  static const greenQ3 = "/greenq3";
  static const greenQ4 = "/greenq4";
  static const greenQ5 = "/greenq5";
  static const greenQ6 = "/greenq6";
  static const greenQ7 = "/greenq7";
  static const greenQ8 = "/greenq8";
  static const greenQ9 = "/greenq9";

  static const violetQ1 = "/violetq1";
  static const violetQ2 = "/violetq2";
  static const violetQ3 = "/violetq3";

  static const pinkQ1 = "/pinkq1";
  static const pinkQ2 = "/pinkq2";
  static const pinkQ3 = "/pinkq3";
  static const pinkQ4 = "/pinkq4";

  static const orangeQ1 = "/orangeq1";
  static const orangeQ2 = "/orangeq2";

  static const child_review = "/child_review";

  static const question_view = "/question_view";


}

var namedRoutes = <String, WidgetBuilder>{	// <String, WidgetBuilder> 생략가능
  RouteName.splash: (context) => IntroScreen(),
  RouteName.fullExam: (context) => FullExampleScreen(),
  RouteName.sightExam: (context) => SightExampleScreen(),
  RouteName.postureExam: (context) => PostureExampleScreen(),
  RouteName.start: (context) => StartScreen(),

  // RouteName.darkblueQ1: (context) => DarkBlue1Screen(),
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

  RouteName.greenQ1: (context) => Green1Screen(),
  RouteName.greenQ2: (context) => Green2Screen(),
  RouteName.greenQ3: (context) => Green3Screen(),
  RouteName.greenQ4: (context) => Green4Screen(),
  RouteName.greenQ5: (context) => Green5Screen(),
  RouteName.greenQ6: (context) => Green6Screen(),
  RouteName.greenQ7: (context) => Green7Screen(),
  RouteName.greenQ8: (context) => Green8Screen(),
  RouteName.greenQ9: (context) => Green9Screen(),

  RouteName.violetQ1: (context) => Violet1Screen(),
  RouteName.violetQ2: (context) => Violet2Screen(),
  RouteName.violetQ3: (context) => Violet3Screen(),

  RouteName.pinkQ1: (context) => Pink1Screen(),
  RouteName.pinkQ2: (context) => Pink2Screen(),
  RouteName.pinkQ3: (context) => Pink3Screen(),
  RouteName.pinkQ4: (context) => Pink4Screen(),

  RouteName.orangeQ1: (context) => Orange1Screen(),
  RouteName.orangeQ2: (context) => Orange2Screen(),

  RouteName.child_review: (contexet) => ChildReview()
  // RouteName.question_view: (contexet) => QuestionView(pageNumber: pageNumber)

};