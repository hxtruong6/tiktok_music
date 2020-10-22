import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class GestureTracking {
  String user;

  GestureTracking(String user) {
    user = user;
  }

  void trackingAction(String songId, String action) {
    String content = user +
        "," +
        action +
        "," +
        DateTime.now().millisecondsSinceEpoch.toString();
    writeToFile(content);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/gesture_tracking.csv');
  }

  Future<File> writeToFile(content) async {
    final file = await _localFile;

    // Write the file

    return file.writeAsString(content, mode: FileMode.append);
  }
}
