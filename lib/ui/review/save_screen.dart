import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:intl/intl.dart';
import '../../repo/shared_preference_manager.dart';
import '../../repo/realtime_database_manager.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({Key? key}) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  DatabaseManager _dbManager = DatabaseManager();

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }

  Future<void> writeDB() async{
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String currentDate = getToday();
    Map<String,dynamic> data = await _prefsManager.getAll();

    _dbManager.writeResult(schoolCode, classId, studentId, currentDate, data);
    _prefsManager.resetAll();
  }

  Future<void> wrtieLocal() async{
    Map<String,dynamic> data = await _prefsManager.getAll();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/wave/beige_wave2.png'),
          Image.asset('assets/images/beige/save/header.png',
              height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      TextButton(
        child: Image.asset('assets/images/beige/save/save.png',
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.35),
        onPressed: () async {
          await writeDB();
        },
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              decoration: InputDecoration(hintText: '연구 보조원 이름 (선택 사항)'),
              style : TextStyle(fontSize:25)
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text('확인', style : TextStyle(fontSize:25)))
        ],
      )
    ]));
  }
}
