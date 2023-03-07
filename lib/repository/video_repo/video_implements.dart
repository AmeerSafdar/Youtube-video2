// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, use_rethrow_when_possible, unused_local_variable, avoid_function_literals_in_foreach_calls, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/models/video_model.dart';
import 'package:task009/repository/video_repo/video_interface.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GetVideoRepo implements GetVideo {
  late VideoPlayerController _videoPlayerController;
  File? video;
  Uint8List? _thumNailImg;
  XFile? videPicked;
  @override
  Future<VideoPlayerController?> pickVideo(ImageSource imageType) async {
    try {
      videPicked = await ImagePicker().pickVideo(source: imageType);
      File tempvideo = File(videPicked!.path);
      video = tempvideo;
      // videoList.add(video);
      Uint8List? img = await getThumbNail();
      // thumbImgList.add(img);
      _videoPlayerController = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          _videoPlayerController.setLooping(true);
          _videoPlayerController.play();
        });
      // controllers.add(_videoPlayerController);
      // videoName.add(videPicked!.name);
    } catch (error) {
      throw error;
    }
    return _videoPlayerController;
  }

  @override
  void pause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
  }

  @override
  void play() {
    if (!_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  @override
  Future<Uint8List?> getThumbNail() async {
    _thumNailImg = await VideoThumbnail.thumbnailData(
      video: video!.path,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );
    return _thumNailImg;
  }

  @override
  void videoList() async {
    VideoPlayerController? _controller;
    List<VideoPlayerController> video_controllers = [];
    for (var i = 0; i < videosList.length; i++) {
      _controller = VideoPlayerController.network(videosList[i].videoURL!)
        ..initialize().then((_) {
          _controller!.setLooping(true);
          _controller.play();
        });

      controllers.add(_controller);
    }
  }
}
