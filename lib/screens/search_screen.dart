import 'package:flutter/material.dart';
import 'package:tiktokmusic/data/music_firebase.dart';
import 'package:tiktokmusic/data/music.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:tiktokmusic/widgets/song_card.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  MusicAPI musicSource;
  List<int> filteredIdx = [];
  List<String> searchFields = [];

  @override
  void initState() {
    // TODO: implement initState
    musicSource = MusicAPI();
    super.initState();
  }

  void handleSearch(String textSearch) async {
    if (textSearch.length < 2) return;
    if (searchFields.isEmpty) {
      await creatSearchFields();
      if (musicSource == null) return;
    }

    final fuse =
        Fuzzy(searchFields, options: FuzzyOptions(minMatchCharLength: 2));
    final result = fuse.search(textSearch);
    filteredIdx = [];

    result.map((r) => r.item).forEach((matched) {
      searchFields.asMap().forEach((index, element) {
        if (element == matched)
          filteredIdx.add(index % (searchFields.length ~/ 3));
      });
    });
    filteredIdx = [
      ...{...filteredIdx}
    ];
    print("xxx 008 index search: $filteredIdx");
  }

  void creatSearchFields() async {
    List<String> titleList = [];
    List<String> authorList = [];
    List<String> singerList = [];

    if (musicSource == null) {
      await musicSource.load();
    }

    musicSource?.listSong?.forEach((song) {
      titleList.add(song.title);
      authorList.add(song.author);
      singerList.add(song.singer);
    });

    searchFields = titleList + authorList + singerList;
    print("xxx 007 serach fields: $searchFields");
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: 350,
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: 250,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search...'),
                                  onChanged: (text) {
                                    handleSearch(text);
                                    setState(() {});
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.qr_code)
                  ],
                ),
              ),
              Text("Your results"),
              Expanded(
                  child: new ListView.builder(
                      itemCount: filteredIdx.length,
                      itemBuilder: (BuildContext ctxt, int Index) {
                        var song = musicSource?.listSong[filteredIdx[Index]];
                        print(song?.title);
                        return new SongWidget(song: song);
                      })),
            ])));
  }
}
