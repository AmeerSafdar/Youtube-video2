// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:task009/helper/utils/dialog_utils.dart';
import 'package:task009/helper/utils/permission_utils.dart';
import 'package:video_player/video_player.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final DialogUtils dialogBox = DialogUtils();
final permissionUtils = PermissionUtils();
// List<File?> videoList = [];
// List<Uint8List?> thumbImgList = [];
List<VideoPlayerController?> controllers = [];
// List<String> videoName = [];
List<double> positionWidget = [];

List<VideoPlayerController?> urlcontrollers = [];
