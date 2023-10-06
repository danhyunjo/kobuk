import 'package:flutter/material.dart';
import 'ui/intro/intro_screen.dart';
import 'core/route/route_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOBUKI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // debugShowCheckedModeBanner : 디버깅 라벨 삭제
      debugShowCheckedModeBanner: false,
      routes: namedRoutes,
      home: const IntroScreen(),
    );
  }
}

