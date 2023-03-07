// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task009/blocs/video_bloc/video_bloc.dart';
import 'package:task009/blocs/video_bloc/video_events.dart';
import 'package:task009/blocs/video_bloc/video_state.dart';
import 'package:task009/helper/constants/icon_helper.dart';
import 'package:video_player/video_player.dart';

class PlayVideoWidget extends StatefulWidget {
  PlayVideoWidget({Key? key, this.video}) : super(key: key);
  VideoPlayerController? video;

  @override
  State<PlayVideoWidget> createState() => _PlayVideoWidgetState();
}

class _PlayVideoWidgetState extends State<PlayVideoWidget> {
  late ChewieController chewie;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    chewie.pause();
  }

  @override
  Widget build(BuildContext context) {
    chewie = ChewieController(
        aspectRatio: widget.video!.value.aspectRatio,
        autoPlay: true,
        looping: true,
        videoPlayerController: widget.video!);
    return Chewie(controller: chewie);
  }
}

class VideoWidget extends StatefulWidget {
  VideoWidget({Key? key, this.asp_ratio, this.video, this.img, this.bloc})
      : super(key: key);
  double? asp_ratio;
  VideoPlayerController? video;
  Uint8List? img;
  VideoBloc? bloc;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void dispose() {
    widget.video!.pause();
    widget.bloc!.add(Pause());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoStates>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.play == true) {
              widget.bloc!.add(Pause());
            } else {
              widget.bloc!.add(Play());
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                  aspectRatio: widget.asp_ratio!,
                  child: state.play == true
                      ? VideoPlayer(widget.video!)
                      : Image.memory(widget.img!)),
              Positioned(
                  child: Center(
                      child: IconButton(
                          onPressed: () {
                            if (state.play == true) {
                              widget.bloc!.add(Pause());
                            } else {
                              widget.bloc!.add(Play());
                            }
                          },
                          icon: state.play == true
                              ? IconHelper.PLAY_ICON1
                              : IconHelper.PLAY_ICON)))
            ],
          ),
        );
      },
    );
  }
}
