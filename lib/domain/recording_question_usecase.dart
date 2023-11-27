import '../repo/audio_player.dart';
import '../repo/audio_recoder.dart';
import '../repo/shared_preference_manager.dart';

class RecordingQuestionUseCase{
  SoundRecorder _audioRecorder = SoundRecorder();
  SoundPlayer _audioPlayer = SoundPlayer();

  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  Stopwatch _stopwatch = Stopwatch();

  Future<bool> startRecording(int pageNumber, int questionNo) async{
    List<int> record_questions = [7, 8, 9, 11, 12, 13, 14, 35, 36];
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
    if (record_questions.contains(pageNumber)) {
      await _audioRecorder.initRecoder();
      await _audioRecorder.startRecoding(
          questionNo, schoolCode, classId, studentId, testStartTime);

      return true;
    }
    return false;
  }
  Future<void> stopRecording(int questionNo) async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
    _audioRecorder.stopRecording(
        schoolCode, classId, studentId, questionNo, testStartTime);
  }

  void saveAnswer(int questionNo) {
    _stopwatch.stop();
    // _audioPlayer.pauseSound();
    if (questionNo != -1) {
      int isRecored = 1;
      _prefsManager.saveRecord(questionNo, isRecored);
    }
  }



}