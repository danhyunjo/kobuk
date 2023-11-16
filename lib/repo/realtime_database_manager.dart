import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {

  Future<void> writeResult(String SchoolCode, String ClassId, String StudentId, String currentDate, Map<String,dynamic> data) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("$SchoolCode-$ClassId-$StudentId-$currentDate");

    await ref.set(data);

  }

}