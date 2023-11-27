import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:kobuk/repo/shared_preference_manager.dart';

class ChildReviewScreen extends StatefulWidget {
  const ChildReviewScreen({Key? key}) : super(key: key);

  @override
  State<ChildReviewScreen> createState() => _ChildReviewScreenState();
}

class _ChildReviewScreenState extends State<ChildReviewScreen> {
  @override
  Widget build(BuildContext context) {
    SharedPreferencesManager _prefsManager = SharedPreferencesManager();
    
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/wave/beige_wave2.png'),
              Image.asset(
                'assets/images/beige/child_review/header.png',
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Image.asset(
                    'assets/images/beige/child_review/choice1.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3),
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.teacher_review);
                  _prefsManager.saveChildReview(1);
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              TextButton(
                child: Image.asset(
                    'assets/images/beige/child_review/choice2.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3),
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.teacher_review);
                  _prefsManager.saveChildReview(0);
                },
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Center(
            child: Image.asset('assets/images/beige/child_review/footer.png',
                width: MediaQuery.of(context).size.height * 0.6),
          )
        ],
      ),
    );
  }
}
