import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String code = '';
  bool canSave = false;

  String getCurrentTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    print("debug ${formatter.format(now)}");
    return formatter.format(now);
  }

  String addLeadingZeroIfNeeded(String input) {
    int number = int.parse(input);
    NumberFormat formatter = NumberFormat('00');

    return formatter.format(number);
  }

  Future<void> makeCode() async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();

    String initialCode = ('K' +
        addLeadingZeroIfNeeded(schoolCode) +
        addLeadingZeroIfNeeded(classId) +
        addLeadingZeroIfNeeded(studentId));

    int countRound = await _dbManager.countRound(schoolCode, classId, studentId) + 1;

    String codeWithRound = initialCode + countRound.toString();

    _prefsManager.saveCode(codeWithRound);


    setState(() {
      code = codeWithRound;
      canSave = true;
    });
  }

  Future<void> saveExtraInfo() async {
    String researcherName =
        _resarcherName.text != "" ? _resarcherName.text : "";
    String currentTime = getCurrentTime();
    _prefsManager.saveResearcherName(researcherName);
    _prefsManager.saveTestFinishTime(currentTime);
  }

  Future<void> writeDB() async {
    await _localManager.checkAndRequestPermissions();

    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();

    Map<String, dynamic> data = await _prefsManager.getAll();

    String error = await _dbManager.writeResult(
        schoolCode, classId, studentId, testStartTime, data);
    if (error == "" && data != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('cloud 저장 성공')));
    } else if (error != "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('cloud 저장 실패 : $error')));
    } else if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('cloud 저장 실패 : 저장할 데이터가 존재하지 않습니다')));
    }
  }

  Future<void> writeLocal() async {
    await _localManager.checkAndRequestPermissions();

    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();

    Map<String, dynamic> data = await _prefsManager.getAll();

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('local 저장 실패 : 저장할 데이터가 존재하지 않습니다')));
    } else {
      try {
        String filePath = await _localManager.writeJsonFile(
            schoolCode, classId, studentId, testStartTime, data);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('local 저장 성공, 파일 경로 : $filePath')));
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('local 저장 실패 : $error')));
      }
    }
  }

  Future<void> resetAll() async {
    await _prefsManager.resetAll();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeCode();
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Image.asset('assets/images/beige/save/save.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.35),
              onPressed: () async {
                if (canSave) {
                  await saveExtraInfo();
                  await writeLocal();
                  await writeDB();
                  await resetAll();
                }
              },
            ),
            Column(
              children: [
                Text('$code',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05)),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)
                  ),
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: "$code"));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('복사 되었습니다')));

                  },
                  child: Text('복사', style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.02, color: Colors.black)

                  ),
                )
              ],
            )

          ],
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
                style: TextStyle(fontSize: 25),
                controller: _resarcherName,
              ),
            ),
          ],
        )
      ]),
    ));
  }
}
