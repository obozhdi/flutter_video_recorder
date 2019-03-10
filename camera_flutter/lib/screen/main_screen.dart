import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../constant/constant.dart';
import 'video_player_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List _videoPath = List();
  double _headerHeight = 320.0;
  final String _assetPlayImagePath = 'assets/images/ic_play.png';
  final String _assetImagePath = 'assets/images/ic_no_video.png';

  var _thumbPath;
  var _videoName;

  _HomeScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Videos"),
      ),
      body: new ListView.builder(
        itemCount: _videoPath.length,
        itemBuilder: (context, rowNumber) {
          return Container(
              padding: new EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget>[
                  _videoPath != null
                      ? _getVideoContainer(rowNumber)
                      : _getImageFromAsset(),
                  new Container(height: 8.0),
                  new Divider(
                    color: Colors.green,
                  )
                ],
              ));
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _recordVideo,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _getImageFromAsset() {
    return ClipPath(
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: Container(
            width: double.infinity,
            height: _headerHeight,
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  _assetImagePath,
                  fit: BoxFit.fill,
                  width: 48.0,
                  height: 32.0,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'No Video Available',
                    style: TextStyle(
                      color: Colors.grey[350],
                      //fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _getVideoContainer(int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      child: new Container(
          width: double.infinity,
          height: _headerHeight,
          color: Colors.grey,
          child: Stack(
            children: <Widget>[
              _thumbPath != null
                  ? new Opacity(
                      opacity: 0.5,
                      child: new Image.file(
                        File(
                          _thumbPath,
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: _headerHeight,
                      ),
                    )
                  : new Container(),
              new Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new VideoPlayerScreen(_videoPath[index])));
                      },
                      child: new Image.asset(
                        _assetPlayImagePath,
                        width: 72.0,
                        height: 72.0,
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text(
                        _videoName != null ? _videoName : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildPathWidget(index)
            ],
          )),
    );
  }

  Widget _buildPathWidget(int index) {
    return _videoPath != null
        ? new Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 100.0,
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
              color: Color.fromRGBO(00, 00, 00, 0.7),
              child: Center(
                child: Text(
                  _videoPath[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        : new Container();
  }

  Widget _getCameraFab() {
    return Positioned(
      top: _headerHeight - 30.0,
      right: 16.0,
      child: FloatingActionButton(
        onPressed: _recordVideo,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future _recordVideo() async {
    final videoPath = await Navigator.of(context).pushNamed(cameraScreen);
    setState(() {
      _videoPath.add(videoPath);
    });
  }
}
