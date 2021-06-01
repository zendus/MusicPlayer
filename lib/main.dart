import 'package:flutter/material.dart';
import 'package:music_player/screens/home_page.dart';
import 'package:music_player/screens/play_multi_songs.dart';

// class MyWidget extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return new IconButton(
//       // Use the MdiIcons class for the IconData
//       icon: new Icon(MdiIcons.sword),
//       onPressed: () { print('Using the sword'); }
//      );
//   }
// }

void main() {
  runApp(MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),

      // color: Colors.black,

      debugShowCheckedModeBanner: false,
      home: AudioPlayerBackgroundPlaylist(),
    );
  }
}
