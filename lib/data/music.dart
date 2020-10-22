import 'dart:developer' as developer;
import 'dart:io';
// import 'package:audio_manager/audio_manager.dart';

class Music {
  String id;
  String url;
  String title;
  String author;
  String desc;
  String coverUrl;
  String singerId;

  Music(
      {this.id,
      this.url,
      this.author,
      this.desc,
      this.title,
      this.coverUrl,
      this.singerId});

  Music.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    url = json['url'];
    author = json['artistName'];
    desc = json['desc'];
    title = json['title'];
    coverUrl = json['coverUrl'];
    singerId = json['singerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['author'] = this.author;
    data['desc'] = this.desc;
    data['title'] = this.title;
    data['coverUrl'] = this.coverUrl;
    data['singerId'] = this.singerId;
    return data;
  }

  // AudioManager musicController = AudioManager.instance;

  Future<Null> loadController() async {
    // Initial playback. Preloaded playback information
    // musicController
    //     .start(
    //       this.url,
    //       this.title,
    //       desc: this.desc,
    //       cover: this.coverUrl,
    //     )
    //     .then((err) => {developer.log('xxx001 play music error: $err')});
  }
}
