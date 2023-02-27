// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task009/blocs/audio_bloc/audio_bloc.dart';
import 'package:task009/blocs/audio_bloc/audio_events.dart';
import 'package:task009/blocs/audio_bloc/audio_state.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/helper/constants/dimensions.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/screens/audio_screen/components/pick_audio_btn.dart';
import 'package:task009/presentation/screens/audio_screen/components/play_btn.dart';
import 'package:task009/presentation/widgets/drawer_widget.dart';
import 'package:task009/presentation/widgets/sized_box.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  Duration? positions, durations;
  late Timer? timer;
  getDuration() {
    timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => BlocProvider.of<AudioBlocs>(context).add(GetDuration()));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  String _printDuration(Duration? duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (duration != null) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    getDuration();
    final bloc = BlocProvider.of<AudioBlocs>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: TextWidgets(txt: StringHelper.AUDIO_SCREEN),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: BlocConsumer<AudioBlocs, AudioStates>(
          listener: (context, state) {
            if (state.isDenied == true) {
              dialogBox.showAlertDialog(context,
                  yesButtonTaped: () => Navigator.pop(context),
                  noBtnPress: () => Navigator.pop(context),
                  action: StringHelper.PERMISSION,
                  titleContent: StringHelper.PERMISSION_DENIED);
            } else if (state.isPermanentlyDenied == true) {
              dialogBox.showAlertDialog(context,
                  yesButtonTaped: () =>
                      Navigator.pop(context, openAppSettings()),
                  noBtnPress: () => Navigator.pop(context),
                  action: StringHelper.PERMISSION,
                  titleContent:
                      '${StringHelper.PERMISSION_DENIED} ${StringHelper.OPEN}');
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.duration != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: TextWidgets(
                            txt: _printDuration(state.position),
                          ),
                        ),
                        Flexible(
                          child: Slider(
                            min: 0,
                            max: state.duration != null
                                ? state.duration!.inMilliseconds.toDouble()
                                : 0.0,
                            value: state.position != null
                                ? state.position!.inMilliseconds.toDouble()
                                : 0.0,
                            onChanged: (val) {
                              durations =
                                  Duration(microseconds: (val * 1000).toInt());
                              bloc.add(Drag(durations));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: TextWidgets(
                            txt: _printDuration(state.duration),
                          ),
                        ),
                      ],
                    ),
                  SizeBoxWidget(heights: Dimensions.D_10),
                  if (state.duration != null) PlayBtn(bloc: bloc, state: state),
                  if (state.duration == null)
                    Center(
                      child: TextWidgets(txt: StringHelper.NO_FILE),
                    ),
                  SizeBoxWidget(heights: Dimensions.D_10),
                  PickAudio(bloc: bloc)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
