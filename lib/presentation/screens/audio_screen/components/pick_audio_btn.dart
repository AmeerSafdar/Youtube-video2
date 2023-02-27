import 'package:flutter/material.dart';
import 'package:task009/blocs/audio_bloc/audio_bloc.dart';
import 'package:task009/blocs/audio_bloc/audio_events.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/widgets/button_widget.dart';

class PickAudio extends StatelessWidget {
  const PickAudio({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final AudioBlocs bloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonWidgets(
        txt: StringHelper.PCIK_AUDIO,
        pressed: () => bloc.add(FetchAudio()),
      ),
    );
  }
}
