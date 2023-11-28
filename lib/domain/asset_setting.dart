import 'dart:html';

import 'package:kobuk/repo/timer.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

import '../repo/audio_player.dart';
import '../repo/audio_recoder.dart';
import '../repo/shared_preference_manager.dart';

class AudioSetting {
  final _audioPlayer = SoundPlayer();
  final _prefsManager = SharedPreferencesManager();
  final _audioRecorder = SoundRecorder();
  final _stopwatch = Stopwatch();
  // final _screenSwitcher = ScreenSwitcher();
  late VideoPlayerController _videoPlayerController;


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
    await listenSoundCompletion();
    await _audioPlayer.playDelayedSound('sounds/page24-6.mp3', 300);
    await listenSoundCompletion();
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

  Future<int> stopRecording(int questionNo) async {
    String schoolCode = await _prefsManager.getSchoolCode();
    String classId = await _prefsManager.getClassId();
    String studentId = await _prefsManager.getStudentId();
    String testStartTime = await _prefsManager.getTestStartTime();
    int isRecorded = await _audioRecorder.stopRecording(
        schoolCode, classId, studentId, questionNo, testStartTime);

    return isRecorded;
  }

  void saveRecordAnswer(int questionNo, int isRecorded) {
    if (questionNo != -1) {
      _prefsManager.saveRecord(questionNo, isRecorded);
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

  void setVideoPlayer(String videoPath){
    _videoPlayerController = VideoPlayerController.asset(
      videoPath,
    )..initialize();
  }

  void playVodeo(){
    _videoPlayerController.play();
  }
  void disposeVideoPlayer(){
    _videoPlayerController.dispose();

  }



}

// import 'package:flutter/material.dart';
// import 'package:kobuk/core/route/route_name.dart';
// import 'package:video_player/video_player.dart';
// import '../../repo/audio_player.dart';
//
// class SightExampleScreen extends StatefulWidget {
//   const SightExampleScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SightExampleScreen> createState() => _SightExampleScreenState();
// }
//
// class _SightExampleScreenState extends State<SightExampleScreen> {
//
//   // final SoundPlayer _audioLogic = SoundPlayer();
//   late VideoPlayerController _videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.asset(
//       'assets/videos/page22.mp4',
//     )..initialize().then((_) {
//       print("Video initialization successful");
//       setState(() {
//         // Start playing the video after initialization
//         // _videoPlayerController.play();
//       });
//       _videoPlayerController.play();
//     });
//   }
//
//
//   @override
//   void dispose() {
//     // _audioLogic.dispose();
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           SizedBox.expand(
//             child: FittedBox(
//               fit: BoxFit.cover,
//               child: SizedBox(
//                 width: _videoPlayerController.value.size?.width ?? 0,
//                 height: _videoPlayerController.value.size?.height ?? 0,
//                 child: VideoPlayer(_videoPlayerController),
//               ),
//             ),
//           ),
//           //FURTHER IMPLEMENTATION
//         ],
//       )
//     //   body: Column(
//       // children: [
//       //   Image.asset('assets/images/wave/light_blue_wave.png'),
//       //   const SizedBox(
//       //     height: 30,
//       //   ),
//       //   Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     children: [
//       //       Image.asset('assets/images/sight_exam.png'),
//       //       TextButton(
//       //           onPressed: () {
//       //             Navigator.pushNamed(context, RouteName.start);
//       //             _audioLogic.pauseSound();
//       //           },
//       //           child: Image.asset(
//       //             'assets/images/arrow.png',
//       //             width: MediaQuery.of(context).size.width * 0.1,
//       //           )),
//       //     ],
//       //   ),
//       //   ],
//       // )
//     );
//   }
// }
