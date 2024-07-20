import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DatabaseManager {

  ///realtime_database에 shared_preference의 내용을 저장
  Future<String> writeResult(String SchoolCode, String ClassId, String StudentId, String testStartTime, Map<String,dynamic> data) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("$SchoolCode-$ClassId-$StudentId-$testStartTime");

    try {
      await ref.set(data);
      return "";
    }catch(e){
      return "$e";
    }

  }
  ///해당 피실험자의 몇번째 실험인지 확인하기 위해 realtime_database에서 해당 피실험자의 기록이 있는지 확인하고, 있다면 count를 증가시킴
  Future<int> countRound(String schoolCode, String classCode, String studentCode) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref().get();
    int count = 0;

    if (snapshot.value != null) {
      Map<dynamic, dynamic>? allItems = snapshot.value as Map<dynamic, dynamic>?;

      if (allItems != null) {
        allItems.forEach((key, value) {
          // String DBcode = value['code'];
          if (value is Map && value['schoolCode'] == schoolCode && value['classId'] == classCode && value['studentId'] == studentCode) {
            count++;
          }
        });
      }
    }

    return count;
  }


}