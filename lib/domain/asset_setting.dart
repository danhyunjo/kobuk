import 'dart:html';

import 'package:kobuk/repo/timer.dart';
import 'package:logger/logger.dart';

import '../repo/audio_player.dart';
import '../repo/audio_recoder.dart';
import '../repo/shared_preference_manager.dart';

class AudioSetting {
  final _audioPlayer = SoundPlayer();
  final _prefsManager = SharedPreferencesManager();
  final _audioRecorder = SoundRecorder();
  final _stopwatch = Stopwatch();
  // final _screenSwitcher = ScreenSwitcher();

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


  Future<void> setPage19Asset() async {
    await _audioPlayer.playDelayedSound('sounds/page24-5.mp3', 400);
    await _audioPlayer.playDelayedSound('sounds/page24-6.mp3', 300);
    await _audioPlayer.playDelayedSound('sounds/page24-7.mp3', 300);
  }

  Future<void> startRecording(int questionNo) async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
        await _audioRecorder.initRecoder();
        await _audioRecorder.startRecoding(
            questionNo, schoolCode, classId, studentId, testStartTime);

  }

  Future<void> stopRecording(int questionNo) async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
    _audioRecorder.stopRecording(
        schoolCode, classId, studentId, questionNo, testStartTime);
  }

  void saveRecordAnswer(int questionNo) {
    // _stopwatch.stop();
    // _audioPlayer.pauseSound();
    if (questionNo != -1) {
      int isRecored = 1;
      _prefsManager.saveRecord(questionNo, isRecored);
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

  Future<void> listenSoundCompletion() async {
    print('listenSoundCompletion start');
    await _audioPlayer.listenAudioCompletion();
    print('listenSoundCompletion end');
  }


  void saveChoiceAnswer(int questionNo, int correctAnswer,
      int selectedAnswer) async {
    _stopwatch.stop();
    // _audioPlayer.pauseSound();
    if (questionNo != -1) {
      int elapsedTime = _stopwatch.elapsed.inSeconds;
      int isCorrect = correctAnswer == selectedAnswer ? 1 : 0;
      _prefsManager.saveAnswer(questionNo, isCorrect, elapsedTime);
    }
  }

}