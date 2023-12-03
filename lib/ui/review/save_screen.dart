import 'package:flutter/material.dart';
import 'package:kobuk/core/route/route_name.dart';
import 'package:intl/intl.dart';
import '../../repo/local_storage_manager.dart';
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
  LocalStorageManager _localManager = LocalStorageManager();
  TextEditingController _resarcherName = TextEditingController();



  Future<void> writeDB() async{
    await _localManager.checkAndRequestPermissions();
    String researcherName = _resarcherName.text != "" ? _resarcherName.text : "";

    _prefsManager.saveResearcherName(researcherName);

    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    Map<String,dynamic> data = await _prefsManager.getAll();

    String error = await _dbManager.writeResult(schoolCode, classId, studentId, data);
    if (error == "" && data != null){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('cloud 저장 성공')));
    } else if (error != ""){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('cloud 저장 실패 : $error')));
    } else if (data == null){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('cloud 저장 실패 : 저장할 데이터가 존재하지 않습니다')));
    }
  }

  Future<void> writeLocal() async{
    await _localManager.checkAndRequestPermissions();
    String researcherName = _resarcherName.text != "" ? _resarcherName.text : "";

    _prefsManager.saveResearcherName(researcherName);

    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();

    Map<String,dynamic> data = await _prefsManager.getAll();

    if (data == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
    SnackBar(content: Text('local 저장 실패 : 저장할 데이터가 존재하지 않습니다')));
    } else {

    try {
      String filePath = await _localManager.writeJsonFile(
          data, schoolCode, classId, studentId);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('local 저장 성공 $filePath')));
    } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('local 저장 실패 : $error')));
      }
      }
    }



  Future<void> resetAll() async{
    await _prefsManager.resetAll();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
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
            await writeLocal();
            await writeDB();
            await resetAll();
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
                style : TextStyle(fontSize:25),
                controller: _resarcherName,
              ),
            ),
          ],
                )
              ]),
        ));
  }
}
