import 'dart:async';

import 'package:logger/logger.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  final audioPlayer = AudioPlayer();
  Completer<void>? completion;


  //오디오 재생이 완료될 때까지 기다리는 함수
  Future<void> listenAudioCompletion() async{
    completion = Completer<void>();

    audioPlayer.onPlayerComplete.listen((event) async{
      // await audioPlayer.play(AssetSource(audioPath));
      completion?.complete();
      completion = null;
    });

    return completion!.future;
}

  //오디오 재생 함수
Future<void> playSound(String audioPath) async {
    await audioPlayer.play(AssetSource(audioPath));
  }
  //매개 변수로 입력받은 만큼(단위는 밀리초) 기다리고, 오디오를 재생하는 함수
  Future<void> playDelayedSound(String audioPath, int delayTime) async {
    print("debug : beforeplay $audioPath");

    await Future.delayed(Duration(milliseconds: delayTime), () async {
      await audioPlayer.play(AssetSource(audioPath));
      print("debug : afterplay $audioPath");
    });
  }

  //오디오 정지 함수
  Future<void> pauseSound() async {
    try{
      await audioPlayer.stop();
    }catch (error) {
      Logger().e(error.toString());
      throw Exception(error);
    }
  }

  //메모리 해제
  void dispose() {
    audioPlayer.dispose();
  }

}