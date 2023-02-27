// ignore_for_file: sort_child_properties_last, use_function_type_syntax_for_parameters, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task009/helper/constants/icon_helper.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/widgets/list_tile_widgets.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class DialogUtils {
  showAlertDialog(BuildContext context,
      {required VoidCallback yesButtonTaped,
      required VoidCallback noBtnPress,
      required String action,
      required String titleContent}) {
    Widget cancelButton = TextButton(
      child: TextWidgets(txt: StringHelper.CANCEL),
      onPressed: noBtnPress,
    );
    Widget continueButton = TextButton(
      child: TextWidgets(txt: StringHelper.OK),
      onPressed: yesButtonTaped,
    );
    AlertDialog alert = AlertDialog(
      title: TextWidgets(txt: action),
      content: TextWidgets(txt: titleContent),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return Future.delayed(Duration.zero, (() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }));
  }

  imagePickDialog(BuildContext context) {
    return AlertDialog(
      title: TextWidgets(txt: StringHelper.PICK_FROM),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          ListTileWidgets(
            icon: IconHelper.IMAGE_ICON,
            tapped: () => Navigator.pop(context, ImageSource.gallery),
            txt: StringHelper.PICK_GALLERY,
          ),
          ListTileWidgets(
            icon: IconHelper.VIDEO_ICON,
            tapped: () => Navigator.pop(context, ImageSource.camera),
            txt: StringHelper.PICK_CAMERA,
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidgets(txt: StringHelper.CANCEL),
          ),
        ],
      )),
    );
  }
}
