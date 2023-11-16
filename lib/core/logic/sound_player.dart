import 'dart:async';

import 'package:logger/logger.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundPlayerLogic {
  final audioPlayer = AudioPlayer();
  Completer<void>? completion;

  Future<void> playAudio(String audioPath) async {
    completion = Completer<void>();

    audioPlayer.onPlayerComplete.listen((event) {
      completion?.complete();
      completion = null;
    });

    await audioPlayer.play(AssetSource(audioPath));

    return completion!.future;
  }


  // Future<void> playSound(String audioPath) async{
  //   try {
  //     // final player = AudioPlayer();
  //     await audioPlayer.play(AssetSource(audioPath));
  //   } catch (error) {
  //     Logger().e(error.toString());
  //     throw Exception(error);
  //   }
  // }


  Future<void> playDelayedSound(String audioPath, int delayTime) async {
    await Future.delayed(Duration(milliseconds: delayTime), () async {
      print("debug : beforeplay $audioPath");
      await playAudio(audioPath);
      print("debug : afterplay $audioPath");
    });
  // }
    // });


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