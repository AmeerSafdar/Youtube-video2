// ignore_for_file: unused_local_variable, dead_code, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task009/blocs/image_bloc/image_bloc.dart';
import 'package:task009/blocs/image_bloc/image_bloc_events.dart';
import 'package:task009/blocs/image_bloc/image_bloc_states.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/widgets/button_widget.dart';

class ImageButtonComponents extends StatelessWidget {
  const ImageButtonComponents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ImageBloc>(context);

    return BlocBuilder<ImageBloc, ImageStates>(
      builder: (context, state) {
        return ButtonWidgets(
          txt: StringHelper.PCIK_IMAGE,
          pressed: () async {
            ImageSource? imgSrc = await showDialog(
              context: context,
              builder: (context) => dialogBox.imagePickDialog(context),
            );
            switch (imgSrc) {
              case ImageSource.camera:
                bloc.add(FetchImage(context, imgSrc!));
                return;

              case ImageSource.gallery:
                bloc.add(FetchImage(context, imgSrc!));
                return;
              default:
                break;
            }
          },
        );
      },
    );
  }
}
