import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:kobuk/repo/firestorage_manager.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  final audioRecoder = FlutterSoundRecorder();
  FirestorageManager _firestorageManager = FirestorageManager();
  bool isRecorderReady = false;

  ///날짜, 시간 불러오는 함수
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }


///녹음 권한 확인하고 녹음기 초기화
  Future<void> initRecoder() async {
    if (await Permission.microphone.request().isGranted) {
    } else {
      await Permission.microphone.request();
    }
    if (await Permission.storage.request().isGranted) {
    } else {
      await Permission.storage.request();
    }
    await audioRecoder.openRecorder();
    isRecorderReady = true;
  }

  Future<void> disposeRecorder() async {
    await audioRecoder.closeRecorder();
    isRecorderReady = false;
  }

  ///녹음 시작 함수
  Future<void> startRecoding(int pageNo, String schoolCode, String classId,
      String studentId, String testStartTime) async {
    if (!isRecorderReady) return;

    //로컬 디바이스의 저장소 경로를 가져와서 녹음 시작
    Directory? ex1 = await getExternalStorageDirectory();
    String dirPath = '${ex1!.path}/$schoolCode-$classId-$studentId/$testStartTime';
    Directory ex2 = await Directory(dirPath).create(recursive: true);

    String filePath = '${ex2.path}/$pageNo.wav';
    await audioRecoder.startRecorder(toFile:filePath);

    print("debug : start Recording $filePath");

  }

  ///녹음 정지 함수
  Future<int> stopRecording(String schoolCode, String classId,
      String studentId, int pageNo, String currentDate) async {
    if (!isRecorderReady) return 0;

    try {
      //로컬 디바이스에 녹음 파일이 저장된 경로를 가져옴
      final filePath = await audioRecoder.stopRecorder();
      File(filePath!);
      print("debug : local file path ${filePath}");

      //녹음 파일을 firesotrage에 저장하는 함수 호출 (경로는 학교 번호, 반 번호 등 피실험자 정보로 구성되어 있음)
      _firestorageManager.writeRecording(
          schoolCode, classId, studentId, pageNo, currentDate);
      return 1;
    } catch ($error) {
      return 0;
    }
  }
}
