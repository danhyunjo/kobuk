// import 'dart:html';

import 'package:logger/logger.dart';
import '../../repo/video_player.dart';
import '../../repo/audio_player.dart';
import '../../repo/audio_recoder.dart';
import '../../repo/shared_preference_manager.dart';

class AudioSetting {
  final _audioPlayer = SoundPlayer();
  final _prefsManager = SharedPreferencesManager();
  final _audioRecorder = SoundRecorder();
  final _stopwatch = Stopwatch();
  final videoPlayer = VideoPlayerRepo();


  Future<void> playSound(String audioPath) async {
    print('playSound start');
    await _audioPlayer.playSound(audioPath);
    print('playSound end');
  }

  Future<void> playDelayedSound(String audioPath, int delayTime) async {
    print('playDelayedSound start');
    await _audioPlayer.playDelayedSound(audioPath, delayTime);
    print('playDelayedSound end');
  }

  void disposeSound(){
    _audioPlayer.dispose();
  }

  void disposeRecorder(){
    _audioRecorder.disposeRecorder();
  }


  Future<void> startRecording(int pageNo) async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
        await _audioRecorder.initRecoder();
        await _audioRecorder.startRecoding(
            pageNo, schoolCode, classId, studentId, testStartTime);

  }

  Future<int> stopRecording(int pageNo) async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
    int isRecorded = await _audioRecorder.stopRecording(
        schoolCode, classId, studentId, pageNo, testStartTime);

    return isRecorded;
  }

  void saveRecordAnswer(int questionNo, int pageNo, int isRecorded) {
    if (questionNo != -1) {
      _prefsManager.saveRecord(pageNo, isRecorded);
    }
  }


  Future<void> setTimer() async {
      try {
        _stopwatch.start();
      } catch (error) {
        Logger().e(error.toString());
        throw Exception(error);
      }

  }

  Future<int> stopTimer() async{
    _stopwatch.stop();

    return _stopwatch.elapsed.inSeconds;
  }

  Future<void> listenSoundCompletion() async {
    print('listenSoundCompletion start');
    await _audioPlayer.listenAudioCompletion();
    print('listenSoundCompletion end');
  }


  void saveChoiceAnswer(int questionNo, int pageNo, int correctAnswer,
      int selectedAnswer, int elapsedTime) async {
    // _stopwatch.stop();
    if (questionNo != -1) {
      // int elapsedTime = _stopwatch.elapsed.inSeconds;
      int isCorrect = correctAnswer == selectedAnswer ? 1 : 0;
      _prefsManager.saveAnswer(pageNo, isCorrect, elapsedTime);
    }
  }

  Future<void> setVideo(String videoPath) async{
    videoPlayer.setVideo(videoPath);
  }

  void playVideo(){
    videoPlayer.playVideo();
  }

  void disposeVideo(){
    videoPlayer.dispose();
  }


}