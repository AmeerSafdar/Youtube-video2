// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class ListTileWidgets extends StatelessWidget {
  ListTileWidgets({
    Key? key,
    required this.icon,
    required this.txt,
    required this.tapped,
  }) : super(key: key);

  VoidCallback tapped;
  Icon icon;
  String txt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tapped,
      leading: icon,
      title: TextWidgets(txt: txt),
    );
  }
}
