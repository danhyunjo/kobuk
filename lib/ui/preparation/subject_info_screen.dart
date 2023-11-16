import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';

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

  Future<void> writeInterruptedResult() async{
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String currentDate = DateTime.now().toString();

    print("debug:{$schoolCode}, {$classId}, {$studentId}");
    if(schoolCode != '' && classId != '' && studentId != ''){
      print("debug : 중단된 테스트 있음");
      Map<String,dynamic> data = await _prefsManager.getAll();
      _dbManager.writeResult(schoolCode, classId, studentId, currentDate, data);
      _prefsManager.resetAll();
    } else {
      print("debug : 중단된 테스트 없음");

    }
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
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.08,
              child: TextField(
                  decoration: InputDecoration(hintText: '학교 코드') ,
                  style : TextStyle(fontSize:25),
                controller: _schoolCodeController,
        
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.08,
              child: TextField(
                  decoration: InputDecoration(hintText: '반 코드') ,
                  style : TextStyle(fontSize:25),
                controller: _classIdController,
        
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.08,
              child: TextField(
                  decoration: InputDecoration(hintText: '출석 번호') ,
                  style : TextStyle(fontSize:25),
                controller: _studentIdController,
        
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () async {
                  Navigator.pushNamed(context, RouteName.intro);
                  await writeInterruptedResult();
                  _prefsManager.saveSubjectInfo(_schoolCodeController.text, _classIdController.text, _studentIdController.text);
        
                }, child: Image.asset('assets/images/preparation/subject_info/boy.png', height: MediaQuery.of(context).size.height*0.25)),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(onPressed: () async{
                  Navigator.pushNamed(context, RouteName.intro);
                  await writeInterruptedResult();
                  _prefsManager.saveSubjectInfo(_schoolCodeController.text, _classIdController.text, _studentIdController.text);
        
                }, child: Image.asset('assets/images/preparation/subject_info/girl.png', height: MediaQuery.of(context).size.height*0.25,))
              ],
            )
        
          ],
        ),
      ),
    );
  }
}
