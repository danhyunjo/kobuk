import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:kobuk/repo/firestorage_manager.dart';
import 'package:logger/logger.dart';

// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  final audioRecoder = FlutterSoundRecorder();
  FirestorageManager _firestorageManager = FirestorageManager();
  bool isRecorderReady = false;

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }

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

  Future<void> startRecoding(int questionNo, String schoolCode, String classId,
      String studentId, String testStartTime) async {
    if (!isRecorderReady) return;

    String currentDate = getToday();

    Directory? ex1 = await getExternalStorageDirectory();

    String dirPath = '${ex1!.path}/$schoolCode-$classId-$studentId/$testStartTime';

    Directory ex2 = await Directory(dirPath).create(recursive: true);

    String filePath = '${ex2.path}/$questionNo.wav';
    await audioRecoder.startRecorder(toFile:filePath);

    print("debug : start Recording $filePath");

  }

  Future<void> stopRecording(String schoolCode, String classId,
      String studentId, int questionNo, String currentDate) async {
    if (!isRecorderReady) return null;

    final filePath = await audioRecoder.stopRecorder();
    File(filePath!);

    print("debug : local file path ${filePath}");
    _firestorageManager.writeRecording(
        schoolCode, classId, studentId, questionNo, currentDate);
  }
}
