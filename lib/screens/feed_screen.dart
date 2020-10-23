import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktokmusic/screens/feed_viewmodel.dart';
import 'package:tiktokmusic/screens/messages_screen.dart';
import 'package:tiktokmusic/screens/music_upload_screen.dart';
import 'package:tiktokmusic/screens/profile_screen.dart';
import 'package:tiktokmusic/screens/search_screen.dart';
import 'package:tiktokmusic/utils/gesture_tracking.dart';
import 'package:tiktokmusic/utils/suggest_index.dart';
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
  PageController _pageController;
  Duration pageTurnDuration = Duration(milliseconds: 300);
  Curve pageTurnCurve = Curves.easeIn;
  SuggestIndex songIdx;

  //TODO: Get user from database
  GestureTracking gestureTracking;

  @override
  void initState() {
    feedViewModel.loadSong(0);
    feedViewModel.loadSong(1);
    _pageController = new PageController(initialPage: 0, viewportFraction: 1);
    gestureTracking = new GestureTracking("hxtruong012");
    super.initState();
  }

  Future changePage(String message) async {
    print(message);
    if (songIdx == null || songIdx.n == null) _createIndex();
    if (message == "R") {
      songIdx.rightGesture();
    } else if (message == "L") {
      songIdx.leftGesture();
    } else if (message == "U") {
      songIdx.upGesture();
    } else if (message == "D") {
      songIdx.downGesture();
    }
    int indexPage = songIdx.idx % songIdx.n;

    // Tracking write to file
    gestureTracking.trackingAction(
        feedViewModel.musicSource.listSong[indexPage].id, message);

    // Change view
    feedViewModel.changeSong(indexPage);
    _pageController.animateToPage(indexPage,
        duration: kTabScrollDuration, curve: Curves.ease);
  }

  void _createIndex() {
    songIdx = new SuggestIndex(feedViewModel.musicSource.listSong.length, 0);
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
          controller: _pageController,
          itemCount: feedViewModel.musicSource.listSong.length,
          // onPageChanged: (index) {
          //   index =
          //       songIdx.idx % songIdx.n; // come back first song if out of list
          //   feedViewModel.changeSong(index);
          //   print("xxx 010 Pagechange: $index");
          // },
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % feedViewModel.musicSource.listSong.length;
            return GestureDetector(
              child: songCard(feedViewModel.musicSource.listSong[index]),
              // Using the DragEndDetails allows us to only fire once per swipe.
              onHorizontalDragEnd: (dragEndDetails) {
                if (dragEndDetails.primaryVelocity < 0) {
                  // Page forwards
                  changePage("L");
                } else if (dragEndDetails.primaryVelocity > 0) {
                  // Page backwards
                  changePage("R");
                }
              },
              onVerticalDragEnd: (dragEndDetails) {
                if (dragEndDetails.primaryVelocity < 0) {
                  changePage("U");
                } else if (dragEndDetails.primaryVelocity > 0) {
                  changePage("D");
                }
              },
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
