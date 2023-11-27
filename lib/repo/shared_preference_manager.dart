import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {

  String addLeadingZero(int number) {
    // Use NumberFormat to format the number with leading zeros
    NumberFormat formatter = NumberFormat('00');
    return formatter.format(number);
  }

  Future<void> saveSubjectInfo(String schoolCode, String classId,
      String studentId, String gender, String testStartTime) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('schoolCode', schoolCode);
    await prefs.setString('classId', classId);
    await prefs.setString('studentId', studentId);
    await prefs.setString('gender', gender);
    await prefs.setString('test_start_time', testStartTime);
  }

  Future<void> saveAnswer(int questionNumber, int answer, int elapsedTime) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('${addLeadingZero(questionNumber)}\_answer', answer);
    await prefs.setInt('${addLeadingZero(questionNumber)}\_elapse_time', elapsedTime);
    await prefs.setInt('${addLeadingZero(questionNumber)}\_error', 0);

    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  Future<void> saveRecord(int questionNumber, int isRecorded) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('${addLeadingZero(questionNumber)}\_is_recorded', isRecorded);
    // await prefs.setInt('$questionNumber\_elapse_time', elapsedTime);
    await prefs.setInt('${addLeadingZero(questionNumber)}\_error', 0);

    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  Future<void> saveChildReview(int childReview) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('child_review', childReview);


    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  Future<void> saveTeacherReview(int teacherReview) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('teacher_review', teacherReview);


    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  Future<void> saveRemark(String remark, String? etc) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('remark', remark);

    if (etc != null){
      await prefs.setString('etc', etc);
    }


    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  Future<Map<String,dynamic>> getAll() async{
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    return prefsMap;
  }


  Future<void> printAll() async {
    final prefs = await SharedPreferences.getInstance();

    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    print(prefsMap);
  }

  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (String key in keys) {
      prefs.remove(key);
    }
  }


    Future<String> getSchoolCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('schoolCode') ?? '';
  }

  Future<String> getClassId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('classId') ?? '';
  }

  Future<String> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('studentId') ?? '';
  }
  Future<String> getTestStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('test_start_time') ?? '';
  }

  Future<int> getAnswer(int questionNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$questionNumber\_answer') ?? 0;
  }

  Future<int> getElapsedTime(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$pageNumber\_elapse_time') ?? 0;

    }
  }

