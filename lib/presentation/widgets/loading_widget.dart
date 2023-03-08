// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/dimensions.dart';
import 'package:task009/presentation/widgets/sized_box.dart';

class LoadingWidgets extends StatelessWidget {
  const LoadingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeBoxWidget(
      heights: SizeConfig.heightMultiplier * Dimensions.D_5,
      childs: const CircularProgressIndicator(),
    );
  }
}
