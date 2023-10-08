import 'package:logger/logger.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundPlayerLogic {
  final audioPlayer = AudioPlayer();
  // final String audioPath;

  // SoundPlayerLogic({required this.audioPath});

  Future<void> playSound(String audioPath) async{
    try {
      final player = AudioPlayer();
      await player.play(AssetSource(audioPath));
    } catch (error) {
      Logger().e(error.toString());
      throw Exception(error);
    }
  }
  void dispose() {
    audioPlayer.dispose();
  }

}