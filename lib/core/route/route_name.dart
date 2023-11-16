import 'package:flutter/cupertino.dart';
import 'package:kobuk/ui/preparation/sight_example_screen.dart';
import 'package:kobuk/ui/preparation/subject_info_screen.dart';
import 'package:kobuk/ui/review/teacher_review_screen.dart';
import '../../ui/preparation/start_screen.dart';
import '../../ui/preparation/intro_screen.dart';
import '../../ui/review/remark_screen.dart';
import '../../ui/review/save_screen.dart';
import '/ui/preparation/full_example_screen.dart';
import '/ui/preparation/posture_example_screen.dart';
import '/ui/review/child_review_screen.dart';





class RouteName {
  static const splash = "/subject_info";
  static const intro = "/intro";
  static const fullExam = "/fullexam";
  static const sightExam = "/sightexam";
  static const postureExam = "/postureexam";
  static const start = "/start";
  static const child_review = "/child_review";
  static const question_view = "/question_view";
  static const teacher_review = "/teacher_review";
  static const remark = "/remark";
  static const save = "/save";


}

var namedRoutes = <String, WidgetBuilder>{	// <String, WidgetBuilder> 생략가능
  RouteName.splash: (context) => SubjectInfoScreen(),
  RouteName.intro: (context) => IntroScreen(),
  RouteName.fullExam: (context) => FullExampleScreen(),
  RouteName.sightExam: (context) => SightExampleScreen(),
  RouteName.postureExam: (context) => PostureExampleScreen(),
  RouteName.start: (context) => StartScreen(),


  RouteName.child_review: (contexet) => ChildReviewScreen(),
  RouteName.teacher_review: (contexet) => TeacherReviewScreen(),
  RouteName.remark: (contexet) => RemarkScreen(),
  RouteName.save: (contexet) => SaveScreen(),

};