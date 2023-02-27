// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class ButtonWidgets extends StatelessWidget {
  ButtonWidgets({super.key, required this.pressed, required this.txt});
  VoidCallback pressed;
  String txt;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: pressed, child: TextWidgets(txt: txt)),
    );
  }
}
