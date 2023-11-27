import '../repo/audio_recoder.dart';
import '../repo/shared_preference_manager.dart';

class ChoiceQuestionUseCase {
  SharedPreferencesManager _prefsManager = SharedPreferencesManager();
  Stopwatch _stopwatch = Stopwatch();


  void saveAnswer(int questionNo, int correctAnswer, int selectedAnswer) async {
    _stopwatch.stop();
    // _audioPlayer.pauseSound();
    if (questionNo != -1) {
      int elapsedTime = _stopwatch.elapsed.inSeconds;
      int isCorrect = correctAnswer == selectedAnswer ? 1 : 0;
      _prefsManager.saveAnswer(questionNo, isCorrect, elapsedTime);
    }
  }
}