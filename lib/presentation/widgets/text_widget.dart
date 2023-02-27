// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
  TextWidgets({super.key, required this.txt, this.style});
  String txt;
  TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      softWrap: false,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
