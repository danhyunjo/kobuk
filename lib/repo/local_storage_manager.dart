import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalStorageManager {

 ///로컬 디바이스의 저장소에 접근 권한이 있는지 확인
  Future<void> checkAndRequestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // 권한이 승인되었으면 외부 저장소에 쓰기를 진행할 수 있습니다.
    } else {
      // 권한이 승인되지 않았으면 요청합니다.
      await Permission.storage.request();
    }
  }

  ///로컬 디바이스의 저장소 경로에 shared_preference에 저장되어 있는 정답 여부를 txt 파일로 저장
  Future<String> writeJsonFile(String schoolCode, String classId, String studentId, String testStartTime, Map<String,dynamic> data) async{

      Directory? ex1 = await getExternalStorageDirectory();

      Directory ex2 = await Directory('${ex1!.path}/$schoolCode-$classId-$studentId').create(recursive: true);
      File file = File('${ex2.path}/$schoolCode-$classId-$studentId-$testStartTime.txt');

      String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);

      print("debug:${file.path}");

      return "${ex2.path}";


  }
}