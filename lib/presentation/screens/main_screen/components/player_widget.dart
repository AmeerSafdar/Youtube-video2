// ignore_for_file: must_be_immutable, avoid_single_cascade_in_expression_statements, unused_field

import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BetterPlaersVideos extends StatefulWidget {
  BetterPlaersVideos({super.key, this.path, this.isPositioned, this.img});
  String? path;
  bool? isPositioned;
  String? img;
  @override
  State<BetterPlaersVideos> createState() => _BetterPlaersVideosState();
}

class _BetterPlaersVideosState extends State<BetterPlaersVideos> {
  late BetterPlayerController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller = BetterPlayerController(
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.path!),
      const BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableOverflowMenu: true,
          showControlsOnInitialize: false,
          enableRetry: true,
          showControls: true,
        ),
      ),
    );
    return widget.isPositioned == true
        ? BetterPlayer(controller: _controller)
        : Image.network(widget.img!);
  }
}

class VideoPlayers extends StatefulWidget {
  VideoPlayers({
    Key? key,
    this.video,
    this.isPositioned,
    this.index,
    this.img,
    this.url,
  }) : super(key: key);
  VideoPlayerController? video;
  bool? isPositioned;
  int? index;
  String? img;
  String? url;
  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  late VideoPlayerController _controller;
  VideoPlayerController? controller;
  late Future<void> futureController;
  initVideo() {
    controller = VideoPlayerController.network(widget.url!);

    futureController = controller!.initialize();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    super.initState();
    initVideo();
    _controller = VideoPlayerController.network(widget.url!)
      ..initialize()
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPositioned == true
        ? Chewie(
            controller: ChewieController(
            aspectRatio: widget.video!.value.aspectRatio,
            videoPlayerController: widget.video!,
            autoPlay: true,
            allowFullScreen: false,
            looping: true,
          ))
        : Image.network(widget.img!);

    // } else {
    //   return Chewie(
    //       controller: ChewieController(
    //     aspectRatio: widget.video!.value.aspectRatio,
    //     videoPlayerController: widget.video!,
    //     autoPlay: false,
    //     allowFullScreen: false,
    //     looping: true,
    //   ));
    // }
    // return
    //     ? Chewie(
    //         controller: ChewieController(
    //         autoInitialize: true,
    //         aspectRatio: widget.video!.value.aspectRatio,
    //         videoPlayerController: widget.video!,
    //         autoPlay: true,
    //         allowFullScreen: false,
    //         looping: true,
    //       ))
    //     : Chewie(
    //         controller: ChewieController(
    //         aspectRatio: widget.video!.value.aspectRatio,
    //         videoPlayerController: widget.video!,
    //         autoPlay: false,
    //         allowFullScreen: false,
    //         looping: true,
    //       ));
  }
}
