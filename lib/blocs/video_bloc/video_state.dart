import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoStates {
  VideoStates(
      {this.video,
      this.thumbnailImg,
      this.play,
      this.isDenied,
      this.isPermanentDenied});
  final VideoPlayerController? video;
  final Uint8List? thumbnailImg;
  bool? play;
  bool? isDenied;
  bool? isPermanentDenied;
  VideoStates copyWith(
      {VideoPlayerController? video,
      Uint8List? thumbnailImg,
      bool? play,
      bool? isDenied,
      bool? isPermanentDenied}) {
    return VideoStates(
        video: video ?? this.video,
        thumbnailImg: thumbnailImg ?? this.thumbnailImg,
        play: play ?? this.play,
        isDenied: isDenied ?? this.isDenied,
        isPermanentDenied: isPermanentDenied ?? this.isPermanentDenied);
  }
}
