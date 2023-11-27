import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

import '../../repo/shared_preference_manager.dart';

class TeacherReviewScreen extends StatefulWidget {
  const TeacherReviewScreen({Key? key}) : super(key: key);

  @override
  State<TeacherReviewScreen> createState() => _TeacherReviewScreenState();
}

class _TeacherReviewScreenState extends State<TeacherReviewScreen> {
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/wave/beige_wave2.png'),
              Image.asset('assets/images/beige/teacher_review/header.png',
                  height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Image.asset(
                    'assets/images/beige/teacher_review/choice1.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.35),
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.remark);
                  _prefsManager.saveTeacherReview(0);
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              TextButton(
                child: Image.asset(
                    'assets/images/beige/teacher_review/choice2.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.35),
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.remark);
                  _prefsManager.saveTeacherReview(1);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
