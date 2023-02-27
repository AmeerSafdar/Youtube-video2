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
        useRootNavigator: true,
        autoPlay: true,
        allowPlaybackSpeedChanging: true,
        looping: true,
        videoPlayerController: widget.video!);
    return Chewie(controller: chewie);
  }
}

class VideoWidget extends StatelessWidget {
  VideoWidget({Key? key, this.asp_ratio, this.video, this.img})
      : super(key: key);
  double? asp_ratio;
  VideoPlayerController? video;
  Uint8List? img;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideoBloc>(context);
    return BlocBuilder<VideoBloc, VideoStates>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.play == true) {
              bloc.add(Pause());
            } else {
              bloc.add(Play());
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                  aspectRatio: asp_ratio!,
                  child: state.play == true
                      ? VideoPlayer(video!)
                      : Image.memory(img!)),
              Positioned(
                  child: Center(
                      child: IconButton(
                          onPressed: () {
                            if (state.play == true) {
                              bloc.add(Pause());
                            } else {
                              bloc.add(Play());
                            }
                          },
                          icon: state.play == true
                              ? IconHelper.PLAY_ICON1
                              : IconHelper.PAUSE_ICON)))
            ],
          ),
        );
      },
    );
  }
}
