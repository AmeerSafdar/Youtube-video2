import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoStates {
  VideoStates(
      {this.video,
      this.controll,
      this.isScroll,
      this.thumbnailImg,
      this.imgLists,
      this.play,
      this.isDenied,
      this.isPermanentDenied});
  final VideoPlayerController? video;
  final Uint8List? thumbnailImg;
  bool? play;
  bool? isDenied;
  bool? isScroll;
  bool? isPermanentDenied;
  List<VideoPlayerController>? controll;
  List<Uint8List>? imgLists;
  VideoStates copyWith({
    VideoPlayerController? video,
    List<VideoPlayerController>? controll,
    List<Uint8List>? imgLists,
    Uint8List? thumbnailImg,
    bool? play,
    bool? isScroll,
    bool? isDenied,
    bool? isPermanentDenied,
  }) {
    return VideoStates(
        video: video ?? this.video,
        thumbnailImg: thumbnailImg ?? this.thumbnailImg,
        isScroll: isScroll ?? this.isScroll,
        play: play ?? this.play,
        isDenied: isDenied ?? this.isDenied,
        controll: controll ?? this.controll,
        imgLists: imgLists ?? this.imgLists,
        isPermanentDenied: isPermanentDenied ?? this.isPermanentDenied);
  }
}
