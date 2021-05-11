import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatelessWidget {
  final _value = 6.0;
  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.only(top: 50),
                height: 380,
                width: 350,

                // child: Center(child: Text('Music Player', style: TextStyle(color: Colors.white),)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('images/sk.png')),
                  // shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Be Kind',
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
                height: 6,
              ),
              Text(
                'Zendus',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 20),
              Slider(
                value: _value,
                min: 0,
                max: 100,
                divisions: 10,
                label: '${_value}',
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Icon(MdiIcons.skipBackward, color: Colors.white, size: 30,),
                // Spacer(),
                Icon(MdiIcons.pauseCircle, color: Colors.blue, size: 50,),
                // Spacer(),
                Icon(MdiIcons.skipForwardOutline, color: Colors.white, size: 30,)

              ],)
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
