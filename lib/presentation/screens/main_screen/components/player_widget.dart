// ignore_for_file: must_be_immutable

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayers extends StatefulWidget {
  VideoPlayers({Key? key, this.video, this.isPositioned, this.index, this.img})
      : super(key: key);
  VideoPlayerController? video;
  bool? isPositioned;
  int? index;
  Uint8List? img;
  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  ChewieController? chewie;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    chewie!.pause();
  }

  @override
  Widget build(BuildContext context) {
    chewie = ChewieController(
      aspectRatio: widget.video!.value.aspectRatio,
      videoPlayerController: widget.video!,
      autoPlay: true,
      allowFullScreen: false,
      looping: true,
    );
    return widget.isPositioned == true
        ? Chewie(controller: chewie!)
        : Image.memory(
            widget.img!,
            fit: BoxFit.cover,
          );
  }
}
