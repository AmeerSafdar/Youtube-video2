import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

abstract class GetVideo {
  Future<VideoPlayerController?> pickVideo(ImageSource imageType);
  void play();
  void pause();
  Future<Uint8List?> getThumbNail();
  Future<List> videoList();
}
