import 'package:image_picker/image_picker.dart';

abstract class GetVideo {}

class FetchVideo extends GetVideo {
  ImageSource src;
  FetchVideo(this.src);
}

class Closed extends GetVideo {}

class Scrolling extends GetVideo {}

class GetVideoList extends GetVideo {}

class Play extends GetVideo {}

class Pause extends GetVideo {}
