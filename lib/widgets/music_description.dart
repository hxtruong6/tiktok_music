import 'package:flutter/material.dart';
import 'package:tiktokmusic/data/music.dart';

class MusicDescription extends StatelessWidget {
  var username;
  var title;
  var songInfo;

  MusicDescription(Music song) {
    username = "hxtruong";
    title = song.title;
    songInfo = "Amazing!";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            height: 120.0,
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '@' + username,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(children: [
                    Icon(
                      Icons.music_note,
                      size: 15.0,
                      color: Colors.white,
                    ),
                    Text(songInfo,
                        style: TextStyle(color: Colors.white, fontSize: 14.0))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                ])));
  }
}
