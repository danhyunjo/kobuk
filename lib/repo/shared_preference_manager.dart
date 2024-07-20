import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {

  ///숫자 포매팅 함수
  String addLeadingZero(int number) {
    NumberFormat formatter = NumberFormat('00');
    return formatter.format(number);
  }

  ///피실험자 정보를 저장
  Future<void> saveSubjectInfo(String schoolCode, String classId,
      String studentId, String gender, String testStartTime) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('schoolCode', schoolCode);
    await prefs.setString('classId', classId);
    await prefs.setString('studentId', studentId);
    await prefs.setString('gender', gender);
    await prefs.setString('test_start_time', testStartTime);
  }

  ///버튼 클릭 문항의 정보를 저장
  Future<void> saveAnswer(int questionNumber, int answer, int elapsedTime) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('${addLeadingZero(questionNumber)}\_answer', answer);
    await prefs.setInt('${addLeadingZero(questionNumber)}\_elapse_time', elapsedTime);

    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  ///오디오 문항의 정보를 저장
  Future<void> saveRecord(int questionNumber, int isRecorded) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('${addLeadingZero(questionNumber)}\_is_recorded', isRecorded);

    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }
    print(prefs);
    print(prefsMap);

  }

  ///실험이 중단되었다가 다시 시작되었는지 여부를 확인하기 위한 함수
  ///start_screen 화면에서 shared preference에 이전 실험 정보가 저장되어 있다면 전송 화면에서 정상적으로 데이터가 전송되지 않은 것이므로 에러 표기
  Future<void> saveError(int isError) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('is_error', isError);
  }

  ///실험 후 아동 리뷰 저장
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

  ///실험 후 선생님 소견 저장
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
  ///실험 후 특이사항 저장
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

  ///실험 후 참여 연구원 이름 저장
  Future<void> saveResearcherName(String name) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('researcher_name', name);
  }

  ///현재 저장되어 있는 shared_preference 내용 반환
  Future<Map<String,dynamic>> getAll() async{
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    return prefsMap;
  }

  ///피실험자 정보를 기반으로 한 피실험자 코드 저장
  Future<void> saveCode(String code) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('code', code);
  }

  ///실험 종료 시간 저장
  Future<void> saveTestFinishTime(String testFinishTime) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('test_finish_time', testFinishTime);
  }

  ///현재 저장되어 있는 shared_preference 내용 출력
  Future<void> printAll() async {
    final prefs = await SharedPreferences.getInstance();

    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    print(prefsMap);
  }

  ///현재 저장되어 있는 shared_preference 모두 삭제
  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (String key in keys) {
      prefs.remove(key);
    }
  }

    ///피실험자 학교 코드 반환
    Future<String> getSchoolCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('schoolCode') ?? '';
  }
  ///피실험자 반 반환
  Future<String> getClassId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('classId') ?? '';
  }
  ///피실험자 학번 반환
  Future<String> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('studentId') ?? '';
  }

  ///피실험자 실험 시작 시간 반환
  Future<String> getTestStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('test_start_time') ?? '';
  }

  }

