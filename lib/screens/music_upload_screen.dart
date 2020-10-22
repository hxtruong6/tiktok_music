import 'package:flutter/material.dart';
import 'package:tiktokmusic/data/music_firebase.dart';

// import 'package:file_picker/file_picker.dart';
import 'package:tiktokmusic/data/music_upload.dart';
import 'package:tiktokmusic/data/music.dart';

class MusicUploadScreen extends StatefulWidget {
  MusicUploadScreen({Key key}) : super(key: key);

  @override
  _MusicUploadScreenState createState() => _MusicUploadScreenState();
}

class _MusicUploadScreenState extends State<MusicUploadScreen> {
  final musicUpload = MusicUpload();
  String coverImageName;
  Map songInfo = {'title': null, 'author': null, 'desc': null, 'singer': null};
  bool uploadSuccess = false;

  void pickupImage() async {
    var coverName = await musicUpload.pickupImage();
    coverImageName = coverName;
  }

  Future handleUploadMusic() async {
    var coverImageUrl = await musicUpload.uploadImage();
    Music musicSong = Music(
      title: songInfo['title'],
      author: songInfo['author'],
      desc: songInfo['desc'],
      singer: songInfo['singer'],
      coverUrl: coverImageUrl,
    );
    await MusicAPI().uploadMusic(musicSong);
    uploadSuccess = true;
  }

  void handleInfoChange(infoType, text) {
    switch (infoType) {
      case 1:
        songInfo['title'] = text;
        break;
      case 2:
        songInfo['author'] = text;
        break;
      case 3:
        songInfo['desc'] = text;
        break;
      case 4:
        songInfo['singer'] = text;
        break;
      default:
        break;
    }
    print("xxx 005 songInfo $songInfo");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Upload music",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.send_outlined),
                    onPressed: () {
                      this.handleUploadMusic();
                      setState(() {});
                    })
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Upload your song",
          ),
          Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Song name'),
              onChanged: (text) {
                handleInfoChange(1, text);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Author'),
              onChanged: (text) {
                handleInfoChange(2, text);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (text) {
                handleInfoChange(3, text);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Singer'),
              onChanged: (text) {
                handleInfoChange(4, text);
              },
            ),
          ]),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.upload_file),
                onPressed: () {},
                tooltip: "Your song",
              ),
              Text('Song')
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.upload_outlined),
                onPressed: () {
                  this.pickupImage();
                  setState(() {});
                },
                tooltip: "Image cover",
              ),
              Text(coverImageName != null ? coverImageName : 'Image cover')
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(uploadSuccess == true ? "Upload your Song successfully!" : "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 30)),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }
}
