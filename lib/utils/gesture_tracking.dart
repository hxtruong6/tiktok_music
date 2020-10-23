import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class GestureTracking {
  String user;

  GestureTracking(String user) {
    this.user = user;
  }

  void trackingAction(String songId, String action) {
    String content = user +
        "," +
        songId +
        "," +
        action +
        "," +
        DateTime.now().millisecondsSinceEpoch.toString() +
        "\n";
    writeToFile(content);
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("_localPath $path");
    return File('$path/gesture_tracking.csv');
  }

  Future<File> writeToFile(content) async {
    final file = await _localFile;
    if (!await file.exists()) {
      content = "USER,SONG_ID,ACTION,TIMPESTAMPE\n" + content;
    }
    // Write the file
    return file.writeAsString(content, mode: FileMode.append);
  }
}
