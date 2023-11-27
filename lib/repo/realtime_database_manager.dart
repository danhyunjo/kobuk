import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DatabaseManager {

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }

  Future<String> writeResult(String SchoolCode, String ClassId, String StudentId, Map<String,dynamic> data) async{
    String currentDate = getToday();
    DatabaseReference ref = FirebaseDatabase.instance.ref("$SchoolCode-$ClassId-$StudentId-$currentDate");

    try {
      await ref.set(data);
      return "";
    }catch(e){
      return "$e";
    }

  }

}