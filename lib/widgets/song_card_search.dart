import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:tiktokmusic/widgets/actions_toolbar.dart';
import 'package:tiktokmusic/widgets/music_description.dart';
import 'package:tiktokmusic/widgets/video_description.dart';
import 'icon_text.dart';
import '../data/music.dart';

class SearchedSongWidget extends StatelessWidget {
  final Music song;

  SearchedSongWidget({@required this.song});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              // child: Image(
              //   height: 90,
              //   width: 150,
              //   fit: BoxFit.cover,
              //   image: FileImage(File(song.coverUrl)),
              // ),
              child: Image.network(
                song.coverUrl ??
                    "https://www.flaticon.com/svg/static/icons/svg/33/33243.svg",
                height: 90,
                width: 150,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                padding: const EdgeInsets.all(7.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            child: Text(song.title,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w700)),
                          ),
                          // Text("Release Year: ${song.year}",
                          //     style: TextStyle(
                          //         fontSize: 11,
                          //         color: Colors.grey,
                          //         fontWeight: FontWeight.w500)),
                          Text("Singer: ${song.singer}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                          Text("Author: ${song.author}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                          // Text(
                          //     "Duration: ${parseToMinutesSeconds(int.parse(song.duration))} min",
                          //     style: TextStyle(
                          //         fontSize: 11,
                          //         color: Colors.grey,
                          //         fontWeight: FontWeight.w500)),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          song.musicController
                              .start(song.url, song.title,
                              desc: song.desc,
                              auto: true,
                              cover: song.coverUrl)
                              .then((err) {
                            print(err);
                          });
                        },
                        child: IconText(
                          iconData: Icons.play_circle_outline,
                          iconColor: Colors.red,
                          string: "Play",
                          textColor: Colors.black,
                          iconSize: 25,
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );

    return SizedBox(
      height: 0,
    );
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
