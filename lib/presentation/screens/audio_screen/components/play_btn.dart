// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task009/blocs/audio_bloc/audio_bloc.dart';
import 'package:task009/blocs/audio_bloc/audio_events.dart';
import 'package:task009/blocs/audio_bloc/audio_state.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/color_helper.dart';
import 'package:task009/helper/constants/icon_helper.dart';
import 'package:task009/helper/constants/screen_percentage.dart';

class PlayBtn extends StatefulWidget {
  PlayBtn({Key? key, required this.bloc, required this.state})
      : super(key: key);

  final AudioBlocs bloc;
  AudioStates state;

  @override
  State<PlayBtn> createState() => _PlayBtnState();
}

class _PlayBtnState extends State<PlayBtn> {
  @override
  void dispose() {
    widget.state.audio!.pause();
    widget.bloc.add(Pause());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * ScreenPercentage.SCREEN_SIZE_10,
      decoration:
          BoxDecoration(color: ColorHelper.K_redAccent, shape: BoxShape.circle),
      child: IconButton(
          color: ColorHelper.K_white,
          onPressed: () {
            if (widget.state.play == true) {
              widget.bloc.add(Pause());
            } else {
              widget.bloc.add(Play());
            }
          },
          icon: widget.state.play == true
              ? IconHelper.PAUSE_ICON
              : IconHelper.PLAY_ICON),
    );
  }
}
