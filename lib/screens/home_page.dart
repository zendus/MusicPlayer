import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AudioPlayer audioPlayer = AudioPlayer();

  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;

  AudioCache audioCache;

  String path = 'Outside.mp3';

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
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      setState(() {
        timeProgress = p.inMilliseconds;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
    super.dispose();
  }

  playMusic() async {
    await audioCache.play(path);
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }


  Future<int> _getAudioDuration() async {
    File audioFile = await audioCache.load(path);
    await audioPlayer.setUrl(
      audioFile.path,
    );

    audioDuration = await Future.delayed(
      Duration(seconds: 2),
      () => audioPlayer.getDuration(),
    );

    return audioDuration;
  }

  Widget getLocalFileDuration() {
    return FutureBuilder<int>(
      future: _getAudioDuration(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('No connection...');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('waiting...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Text(getTimeString(snapshot.data));
        }
        return null;
      },
    );
  }

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
              SizedBox(height: screenSize.height / 40),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTimeString(timeProgress),
                      style: TextStyle(color: Colors.white),
                    ),
                    // SizedBox(width: screenSize.width / 90),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 200,
                      // width: screenSize.width / 1.5,
                      child: slider(),
                    ),
                    // SizedBox(width: screenSize.width / 90),
                    SizedBox(
                      width: 20,
                    ),
                    audioDuration == 0
                        ? getLocalFileDuration()
                        : Text(
                            getTimeString(audioDuration),
                            style: TextStyle(color: Colors.white),
                          )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(
                          MdiIcons.skipBackward,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {}),
                    // Spacer(),
                    IconButton(
                        icon: Icon(
                          audioPlayerState == AudioPlayerState.PLAYING
                              ? MdiIcons.pauseCircle
                              : MdiIcons.playCircle,
                          color: Colors.blue,
                          size: 40,
                        ),
                        onPressed: () {
                          audioPlayerState == AudioPlayerState.PLAYING
                              ? pauseMusic()
                              : playMusic();
                        }),
                    // Spacer(),
                    IconButton(
                        icon: Icon(
                          MdiIcons.skipForwardOutline,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
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
