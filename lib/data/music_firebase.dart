import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktokmusic/data/demo_data.dart';
import 'music.dart';

class MusicAPI {
  List<Music> listSong = List<Music>();

  MusicAPI() {
    load();
  }

  void load() async {
    listSong = await getSongList();
  }

  Future<List<Music>> getSongList() async {
    var data = await FirebaseFirestore.instance.collection("Music").get();
    var songList = <Music>[];

    // if (data.docs.length == 0) {
    //   await addDemoData();
    //   data = (await FirebaseFirestore.instance.collection("Music").get());
    // }

    data.docs.forEach((element) {
      Music song = Music.fromJson(element.data());
      songList.add(song);
    });

    return songList;
  }

  Future<Null> addDemoData() async {
    for (var song in data) {
      await FirebaseFirestore.instance.collection("Music").add(song);
    }
  }
}
