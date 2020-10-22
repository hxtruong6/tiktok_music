import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/services.dart';
import 'package:tiktokmusic/data/music_firebase.dart';
import 'package:stacked/stacked.dart';

class FeedViewModel extends BaseViewModel {
  // VideoPlayerController controller;
  // AudioManager musicController;
  // VideosAPI videoSource;
  MusicAPI musicSource;

  int prevVideo = 0;
  int prevSong = 0;

  int actualScreen = 0;

  FeedViewModel() {
    // videoSource = VideosAPI();
    musicSource = MusicAPI();
  }

  // changeVideo(index) async {
  //   videoSource.listVideos[prevVideo].controller.pause();
  //   if (videoSource.listVideos[index].controller == null) {
  //     await videoSource.listVideos[index].loadController();
  //   }
  //   videoSource.listVideos[index].controller.play();
  //   videoSource.listVideos[prevVideo].controller.removeListener(() {});
  //
  //   //videoSource.listVideos[prevVideo].controller.dispose();
  //
  //   prevVideo = index;
  //   notifyListeners();
  //
  //   print(index);
  // }

  changeSong(index) async {
    // musicSource.listSong[prevSong].musicController.toPause();
    // if (musicSource.listSong[index].musicController == null) {
    //   await musicSource.listSong[index].loadController();
    // }
    //
    // musicSource.listSong[index].musicController.toPlay();

    // videoSource.listVideos[prevVideo].controller.removeListener(() {});
    //videoSource.listVideos[prevVideo].controller.dispose();

    prevSong = index;
    notifyListeners();
    print('xxx 002 Play song index $index');
  }

  // void loadVideo(int index) async {
  //   await videoSource.listVideos[index].loadController();
  //   //videoSource.listVideos[index].controller.play();
  //   notifyListeners();
  // }

  void loadSong(int index) async {
    await musicSource.listSong[index].loadController();
    notifyListeners();
  }


  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
