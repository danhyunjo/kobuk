import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../repo/shared_preference_manager.dart';
import '../../repo/realtime_database_manager.dart';

class SubjectInfoScreen extends StatefulWidget {
  const SubjectInfoScreen({Key? key}) : super(key: key);

  @override
  State<SubjectInfoScreen> createState() => _SubjectInfoScreenState();
}

class _SubjectInfoScreenState extends State<SubjectInfoScreen> {
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  DatabaseManager _dbManager = DatabaseManager();
  TextEditingController _schoolCodeController = TextEditingController();
  TextEditingController _classIdController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // 권한이 승인되었으면 외부 저장소에 쓰기를 진행할 수 있습니다.
    } else {
      // 권한이 승인되지 않았으면 요청합니다.
      await Permission.storage.request();
    }
    if (await Permission.microphone.request().isGranted) {
    } else {
      await Permission.microphone.request();
    }
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }

  Future<void> writeInterruptedResult() async{
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();


    print("debug:{$schoolCode}, {$classId}, {$studentId}");
    if(schoolCode != '' || classId != '' || studentId != ''){
      print("debug : 중단된 테스트 있음");
      if (schoolCode != '' && classId != '' && studentId != '') {
        _prefsManager.saveError(1);
        Map<String, dynamic> data = await _prefsManager.getAll();
        _dbManager.writeResult(schoolCode, classId, studentId, data);
      }
      _prefsManager.resetAll();
    } else {
      print("debug : 중단된 테스트 없음");

    }
  }

  @override
  void initState(){
    checkAndRequestPermissions();
  }
  @override
  void dispose(){
    _schoolCodeController.dispose();
    _classIdController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/wave/light_blue_wave2.png'),
                Image.asset(
                    'assets/images/preparation/subject_info/header.png',
                    height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextField(
                    decoration: InputDecoration(hintText: '학교 코드') ,
                    style : TextStyle(fontSize:25),
                    controller: _schoolCodeController,

                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextField(
                    decoration: InputDecoration(hintText: '반 코드') ,
                    style : TextStyle(fontSize:25),
                    controller: _classIdController,

                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: TextField(
                    decoration: InputDecoration(hintText: '개인 코드') ,
                    style : TextStyle(fontSize:25),
                    controller: _studentIdController,

                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () async {
                  Navigator.pushNamed(context, RouteName.intro);
                  await writeInterruptedResult();
                  String testStartTime = getToday();
                  _prefsManager.saveSubjectInfo(_schoolCodeController.text, _classIdController.text, _studentIdController.text, 'male', testStartTime);
                  _prefsManager.saveError(0);

                }, child: Image.asset('assets/images/preparation/subject_info/boy.png', height: MediaQuery.of(context).size.height*0.20)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(onPressed: () async{
                  Navigator.pushNamed(context, RouteName.intro);
                  await writeInterruptedResult();
                  String testStartTime = getToday();
                  _prefsManager.saveSubjectInfo(_schoolCodeController.text, _classIdController.text, _studentIdController.text, 'female', testStartTime);
                  _prefsManager.saveError(0);
        
                }, child: Image.asset('assets/images/preparation/subject_info/girl.png', height: MediaQuery.of(context).size.height*0.20,))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          ],
        ),
      ),
    );
  }
}
