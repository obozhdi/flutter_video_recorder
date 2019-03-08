import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';


void main() => runApp(new CameraApp());

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Camera App",
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text("Camera App"),
            ),
            body: new ListWidget(),
            floatingActionButton: new FloatingActionButton(
              onPressed: () {
                print("tap add");
              },
              backgroundColor: Colors.red,
              mini: false,
              child: new Icon(Icons.add),
            )));
  }
}

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: 20,
      itemBuilder: (context, rowNumber) {
        return Container(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Image.network("https://goo.gl/vFdXGc"),
                new Container(height: 8.0),
                new Text(
                  "Video taken at 0202 $rowNumber",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                new Divider(
                  color: Colors.green,
                )
              ],
            ));
      },
    );
  }
}
