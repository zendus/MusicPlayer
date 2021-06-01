import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AudioPlayerBackgroundPlaylist extends StatefulWidget {
  @override
  _AudioPlayerBackgroundPlaylistState createState() =>
      _AudioPlayerBackgroundPlaylistState();
}

class _AudioPlayerBackgroundPlaylistState
    extends State<AudioPlayerBackgroundPlaylist> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  int timeProgress = 0;

  int audioDuration = 0;

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: (timeProgress / 1000).floorToDouble(),
          max: (audioDuration / 1000).floorToDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  playMusic() async {
    await audioPlayer.play();
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }

  skipPrevious() async {
    await audioPlayer.previous();
  }

  skipNext() async {
    await audioPlayer.next();
  }

  // Widget slider() {
  //   return Container(
  //     width: 300.0,
  //     child: Slider.adaptive(
  //         value: (timeProgress / 1000).floorToDouble(),
  //         max: (audioDuration / 1000).floorToDouble(),
  //         onChanged: (value) {
  //           seekToSec(value.toInt());
  //         }),
  //   );
  // }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer.seek(newPos);
  }

  String getTimeString(int milliseconds) {
    if (milliseconds == null) milliseconds = 0;
    String minutes =
        '${(milliseconds / 60000).floor() < 10 ? 0 : ''}${(milliseconds / 60000).floor()}';
    String seconds =
        '${(milliseconds / 1000).floor() % 60 < 10 ? 0 : ''}${(milliseconds / 1000).floor() % 60}';
    return '$minutes:$seconds';
  }

  void setupPlaylist() async {
    audioPlayer.open(
        Playlist(audios: [
          Audio('assets/emtee.mp3',
              metas: Metas(title: 'Thank You', artist: 'Emtee')),
          Audio('assets/Outside.mp3',
              metas: Metas(title: 'Outside', artist: 'Buju')),
          Audio('assets/mtz.mp3',
              metas: Metas(title: 'Una como lady', artist: 'Manuel Torizo')),
          Audio('assets/bailando.mp3',
              metas: Metas(title: 'Bailando', artist: 'Artist')),
        ]),
        showNotification: true,
        autoStart: false);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(MdiIcons.chevronDown, size: 30),
            Text(
              'Now Playing',
              style: TextStyle(fontSize: 20),
            ),
            Icon(MdiIcons.starOutline, size: 25)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: screenSize.height / 2.2,
                // width: screenSize.height / 2,

                // child: Center(child: Text('Music Player', style: TextStyle(color: Colors.white),)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/buju.jpeg')),
                  // shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(
                height: screenSize.height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Outside',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 35,
                          color: Colors.white)),
                  Spacer(),
                  Icon(
                    MdiIcons.heart,
                    color: Colors.blue,
                    size: 35,
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height / 80,
              ),
              Text(
                'Buju',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: screenSize.height / 20),
              audioPlayer.builderIsPlaying(builder: (context, isPlaying) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.skip_previous_rounded),
                        iconSize: 50,
                        onPressed: () => skipPrevious()),
                    IconButton(
                        color: Colors.white,
                        icon: Icon(isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded),
                        iconSize: 50,
                        onPressed: () =>
                            isPlaying ? pauseMusic() : playMusic()),
                    IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.skip_next_rounded),
                        iconSize: 50,
                        onPressed: () => skipNext()),
                  ],
                );
              }),
              SizedBox(height: screenSize.height / 40),
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(MdiIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.heartOutline), label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.playlistMusicOutline), label: 'Playlist'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
