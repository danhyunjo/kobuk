import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalStorageManager {

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }


  Future<void> checkAndRequestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // 권한이 승인되었으면 외부 저장소에 쓰기를 진행할 수 있습니다.
    } else {
      // 권한이 승인되지 않았으면 요청합니다.
      await Permission.storage.request();
    }
  }

  Future<String> writeJsonFile(Map<String,dynamic> data, String schoolCode, String classId, String studentId) async{

    try {
      String currentDate = getToday();

      Directory? ex1 = await getExternalStorageDirectory();

      Directory ex2 = await Directory('${ex1!.path}/$schoolCode-$classId-$studentId').create(recursive: true);
      File file = File('${ex2.path}/$schoolCode-$classId-$studentId-$currentDate.txt');

      String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);

      print("debug:${file.path}");

      return "";
    } catch (e){
      return "$e";
    }

  }
}