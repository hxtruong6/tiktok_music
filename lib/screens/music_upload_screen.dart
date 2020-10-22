import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:tiktokmusic/data/music_upload.dart';

class MusicUploadScreen extends StatefulWidget {
  MusicUploadScreen({Key key}) : super(key: key);

  @override
  _MusicUploadScreenState createState() => _MusicUploadScreenState();
}

class _MusicUploadScreenState extends State<MusicUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final musicUpload = MusicUpload();

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
                    // Icon(Icons.arrow_drop_down),
                  ],
                ),
                Icon(Icons.send)
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.upload_sharp,
          //       size: 80,
          //       color: Colors.black45,
          //     )
          //   ],
          // ),
          Text(
            "Upload your song",
          ),
          Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Song name'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Author'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                //  TODO: select song
                // TODO: select image
              ])),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.upload_file),
                onPressed: () {
                  // musicUpload.pickupSong();
                },
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
                onPressed: () {},
                tooltip: "Image cover",
              ),
              Text('Image cover')
            ],
          ),
        ]),
      ),
    );
  }
}
