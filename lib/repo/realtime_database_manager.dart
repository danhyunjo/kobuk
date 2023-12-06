import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DatabaseManager {


  Future<String> writeResult(String SchoolCode, String ClassId, String StudentId, String testStartTime, Map<String,dynamic> data) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("$SchoolCode-$ClassId-$StudentId-$testStartTime");

    try {
      await ref.set(data);
      return "";
    }catch(e){
      return "$e";
    }

  }

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