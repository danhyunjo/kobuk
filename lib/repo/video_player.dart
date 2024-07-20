import 'dart:async';

import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerRepo {
  late VideoPlayerController videoPlayerController;

  ///비디오 초기화 함수
  Future<void> setVideo(String videoPath) async {
    videoPlayerController = VideoPlayerController.asset(videoPath);
    await videoPlayerController.initialize();
  }
  ///비디오 재생 함수
  void playVideo() {
  videoPlayerController.play();  // 자동 재생

}
  ///비디오 종료 리스너 함수
  Future<void> listenVideoCompletion(Function onCompleted) async{
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position ==
              videoPlayerController.value.duration) {
        onCompleted();
      }
    }
    );
  }

  void dispose() {
    videoPlayerController.dispose();
  }

}