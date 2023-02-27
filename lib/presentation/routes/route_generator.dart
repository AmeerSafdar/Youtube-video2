// ignore_for_file: unused_local_variable, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:task009/presentation/screens/audio_screen/audio_screen.dart';
import 'package:task009/presentation/screens/image_screen/image_screen.dart';
import 'package:task009/presentation/screens/main_screen/main_screen.dart';
import 'package:task009/presentation/screens/video_screen/video_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (context) => MainScreens());
      case '/videoscreen':
        return CupertinoPageRoute(builder: (context) => VideoScreen());
      case '/imagescreen':
        return CupertinoPageRoute(builder: (context) => ImageScreen());
      case '/audioscreen':
        return CupertinoPageRoute(builder: (context) => AudioScreen());
      default:
        return CupertinoPageRoute(builder: (context) => MainScreens());
    }
  }
}
