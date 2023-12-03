import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobuk/ui/preparation/subject_info_screen.dart';
import 'package:kobuk/ui/test.dart';
import 'ui/preparation/intro_screen.dart';
import 'core/route/route_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebas'
    'e_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // 초기화를 보장합니다.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]); //한쪽 방향 고정

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]); //가로 좌우로 고정



    return MaterialApp(
      title: 'KOBUKI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // debugShowCheckedModeBanner : 디버깅 라벨 삭제
      debugShowCheckedModeBanner: false,
      routes: namedRoutes,
      home: SubjectInfoScreen(),
    );
  }
}

