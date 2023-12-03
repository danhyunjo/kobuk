import 'dart:async';

import 'package:flutter/material.dart';



class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  double progressValue = 0.0;
  bool isTextVisible = true;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  // Function to start the animation
  void startAnimation() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Toggle the visibility of the text
        isTextVisible = !isTextVisible;

        // Update the progress value
        progressValue += 0.1;
        if (progressValue > 1.0) {
          progressValue = 0.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Progress Bar with Blinking Text'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 300.0,
              height: 50.0,

              child: Stack(
                children: [
                  // AnimatedBuilder to handle the progress bar animation
                  AnimatedBuilder(
                    animation: Tween<double>(begin: 0.0, end: 300.0).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.linear,
                      ),
                    ),
                    builder: (context, child) {
                      return Positioned(
                        left: progressValue * 300.0,
                        child: Container(
                          width: 30.0,
                          height: 50.0,
                          color: Colors.blue,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Stack(
                children: [
                  // Centered blinking text
                  Center(
                    child: Opacity(
                      opacity: isTextVisible ? 1.0 : 0.0,
                      child: Text(
                        'Loading...',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      )
    );
  }
}