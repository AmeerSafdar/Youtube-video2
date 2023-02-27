import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

abstract class GetImage {}

class FetchImage extends GetImage {
  BuildContext context;
  ImageSource imgSrc;
  FetchImage(this.context, this.imgSrc);
}

class Closed extends GetImage {}
