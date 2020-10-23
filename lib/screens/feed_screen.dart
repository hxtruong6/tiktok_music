import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktokmusic/screens/feed_viewmodel.dart';
import 'package:tiktokmusic/screens/messages_screen.dart';
import 'package:tiktokmusic/screens/music_upload_screen.dart';
import 'package:tiktokmusic/screens/profile_screen.dart';
import 'package:tiktokmusic/screens/search_screen.dart';
import 'package:tiktokmusic/widgets/bottom_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:tiktokmusic/widgets/song_card.dart';
import 'package:tiktokmusic/screens/profile_view.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();

  @override
  void initState() {
    feedViewModel.loadSong(0);
    feedViewModel.loadSong(1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => videoScreen(),
        viewModelBuilder: () => feedViewModel);
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: GetIt.instance<FeedViewModel>().actualScreen == 0
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            onPageChanged: (value) {
              print(value);
              if (value == 1)
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              else
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return scrollFeed();
              else
                return profileView();
            },
          )
        ],
      ),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: currentScreen()),
        BottomBar(),
      ],
    );
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: feedViewModel.musicSource.listSong.length,
          onPageChanged: (index) {
            index = index %
                (feedViewModel.musicSource.listSong
                    .length); // come back first song if out of list
            feedViewModel.changeSong(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (feedViewModel.musicSource.listSong.length);
            return SizedBox(
              width: double.infinity,
              child: songCard(feedViewModel.musicSource.listSong[index]),
            );
          },
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Following',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70)),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    color: Colors.white70,
                    height: 10,
                    width: 1.0,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text('For You',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ]),
          ),
        ),
      ],
    );
  }

  Widget currentScreen() {
    switch (feedViewModel.actualScreen) {
      case 0:
        return feedVideos();
      case 1:
        return SearchScreen();
      case 2:
        return MessagesScreen();
      case 3:
        return ProfileScreen();
      case 4:
        return MusicUploadScreen();
      default:
        return feedVideos();
    }
  }

  @override
  void dispose() {
    // feedViewModel.controller.dispose();
    // feedViewModel.musicController.stop();
    super.dispose();
  }
}
