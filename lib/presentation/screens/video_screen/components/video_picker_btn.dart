// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task009/blocs/video_bloc/video_bloc.dart';
import 'package:task009/blocs/video_bloc/video_events.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/widgets/button_widget.dart';

class VideoPicker extends StatelessWidget {
  const VideoPicker({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final VideoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return ButtonWidgets(
        txt: StringHelper.PCIK_VIDEO,
        pressed: () async {
          ImageSource? imgSrc = await showDialog(
            context: context,
            builder: (context) => dialogBox.imagePickDialog(context),
          );
          switch (imgSrc) {
            case ImageSource.camera:
              bloc.add(FetchVideo(imgSrc!));
              return;

            case ImageSource.gallery:
              bloc.add(FetchVideo(imgSrc!));
              return;
            default:
              break;
          }
        });
  }
}
