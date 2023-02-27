// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SizeBoxWidget extends StatelessWidget {
  SizeBoxWidget({super.key, this.heights, this.childs, this.widths});
  double? heights;
  double? widths;
  Widget? childs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heights,
      width: widths,
      child: childs,
    );
  }
}
