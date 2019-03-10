import 'package:camera/camera.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'constant/constant.dart';
import 'screen/camera_screen.dart';
import 'screen/main_Screen.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code);
    print(e.description);
  }

  runApp(
    MaterialApp(
      title: "Camera App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        homeScreen: (BuildContext context) => HomeScreen(),
        cameraScreen: (BuildContext context) => CameraHomeScreen(cameras),
      },
    ),
  );
}
