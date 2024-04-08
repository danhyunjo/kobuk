import 'dart:async';

import 'package:logger/logger.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  final audioPlayer = AudioPlayer();
  Completer<void>? completion;



  Future<void> listenAudioCompletion() async{
    completion = Completer<void>();

    audioPlayer.onPlayerComplete.listen((event) async{
      // await audioPlayer.play(AssetSource(audioPath));
      completion?.complete();
      completion = null;
    });

    return completion!.future;
}

Future<void> playSound(String audioPath) async {
    await audioPlayer.play(AssetSource(audioPath));
  }

  Future<void> playDelayedSound(String audioPath, int delayTime) async {
    print("debug : beforeplay $audioPath");
    // await listenAudioCompletion();
    await playSound(audioPath);
    await Future.delayed(Duration(milliseconds: delayTime), () async {
      print("debug : afterplay $audioPath");
    });
  }

  Future<void> pauseSound() async {
    try{
      await audioPlayer.stop();
    }catch (error) {
      Logger().e(error.toString());
      throw Exception(error);
    }
  }

  void dispose() {
    audioPlayer.dispose();
  }

}