import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {


  Future<void> saveChildInfo(String schoolCode, int classId,
      int studentId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('SchoolCode', schoolCode);
    await prefs.setInt('classId', classId);
    await prefs.setInt('studentId', studentId);
  }

  Future<void> saveAnswer(int questionNumber, int answer, int elapsedTime) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('$questionNumber\_answer', answer);
    await prefs.setInt('$questionNumber\_elapse_time', elapsedTime);
    await prefs.setInt('$questionNumber\_error', 0);

  }

  Future<void> saveRecord(int questionNumber, int isRecorded, int elapsedTime) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('$questionNumber\is_recorded', isRecorded);
    await prefs.setInt('$questionNumber\_elapse_time', elapsedTime);
    await prefs.setInt('$questionNumber\_error', 0);

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
    return prefs.getString('name') ?? '';
  }

  Future<int> getClassId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('classId') ?? -1;
  }

  Future<int> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('studentId') ?? 0;
  }

  Future<int> getAnswer(int questionNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$questionNumber\_answer') ?? 0;
  }

  Future<int> getElapsedTime(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$pageNumber\_elapse_time') ?? 0;

    Future<void> exportToCSV() async {
      // Create and export the CSV file with data from SharedPreferences.
      // You can use the csv package for this.
      // For Firebase Realtime Database, see step 6 in the previous response.
    }
  }
}
