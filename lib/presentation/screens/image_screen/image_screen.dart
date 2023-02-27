// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task009/blocs/image_bloc/image_bloc.dart';
import 'package:task009/blocs/image_bloc/image_bloc_states.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/helper/constants/dimensions.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/screens/image_screen/components/image_picker_btn.dart';
import 'package:task009/presentation/screens/image_screen/components/show_image_widget.dart';
import 'package:task009/presentation/widgets/drawer_widget.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(StringHelper.IMAGE_SCREEN),
      ),
      body: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: BlocConsumer<ImageBloc, ImageStates>(
            listener: (context, state) {
              if (state.denied == true) {
                dialogBox.showAlertDialog(context,
                    yesButtonTaped: () => Navigator.pop(context),
                    noBtnPress: () => Navigator.pop(context),
                    action: StringHelper.PERMISSION,
                    titleContent: StringHelper.PERMISSION_DENIED);
              } else if (state.permanent_denied == true) {
                dialogBox.showAlertDialog(context,
                    yesButtonTaped: () =>
                        Navigator.pop(context, openAppSettings()),
                    noBtnPress: () => Navigator.pop(context),
                    action: StringHelper.PERMISSION,
                    titleContent:
                        '${StringHelper.PERMISSION_PERMANENT_DENIED}\n${StringHelper.OPEN}');
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  if (state.img != null)
                    ShowImageWidget(img: state.img)
                  else
                    Expanded(
                        child: Center(
                            child: TextWidgets(txt: StringHelper.NO_FILE))),
                  Expanded(child: Container()),
                  ImageButtonComponents()
                ],
              );
            },
          )),
    );
  }
}
