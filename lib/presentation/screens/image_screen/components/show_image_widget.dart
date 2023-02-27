// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/screen_percentage.dart';

class ShowImageWidget extends StatelessWidget {
  ShowImageWidget({Key? key, this.img}) : super(key: key);
  File? img;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * ScreenPercentage.SCREEN_SIZE_50,
        width: double.infinity,
        child: Image.file(
          img!,
          fit: BoxFit.cover,
        ));
  }
}
