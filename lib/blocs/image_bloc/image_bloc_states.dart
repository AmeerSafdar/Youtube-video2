// ignore_for_file: non_constant_identifier_names, unnecessary_this

import 'dart:io';

class ImageStates {
  ImageStates({this.img, this.denied, this.permanent_denied});

  final File? img;
  bool? denied;
  bool? permanent_denied;

  ImageStates copyWith({File? img, bool? denied, bool? permanent_denied}) {
    return ImageStates(
        img: img ?? this.img,
        denied: denied ?? this.denied,
        permanent_denied: permanent_denied ?? this.permanent_denied);
  }
}
