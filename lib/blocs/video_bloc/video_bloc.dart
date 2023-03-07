// ignore_for_file: prefer_const_constructors, await_only_futures, use_build_context_synchronously, use_rethrow_when_possible

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task009/blocs/video_bloc/video_events.dart';
import 'package:task009/blocs/video_bloc/video_state.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/repository/video_repo/video_implements.dart';
import 'package:video_player/video_player.dart';

class VideoBloc extends Bloc<GetVideo, VideoStates> {
  GetVideoRepo getVideRepo = GetVideoRepo();
  VideoPlayerController? video;
  Uint8List? thumbImg;
  List<VideoPlayerController> controllers = [];

  VideoBloc({required this.getVideRepo}) : super(VideoStates()) {
    on<FetchVideo>(_fetchVideo);
    on<Play>(_play);
    on<Pause>(_pause);
    on<Scrolling>(_getVideos);
  }
  void _getVideos(Scrolling event, Emitter<VideoStates> emit) async {
    try {
      // getVideRepo.videoList();
      emit(state.copyWith(isScroll: true));
    } catch (exc) {
      throw exc;
    }
  }

  void _play(Play event, Emitter<VideoStates> emit) {
    getVideRepo.play();
    emit(state.copyWith(
      play: true,
    ));
  }

  void _pause(event, emit) {
    getVideRepo.pause();
    emit(state.copyWith(
      play: false,
    ));
  }

  Future<void> _fetchVideo(FetchVideo event, Emitter<VideoStates> emit) async {
    try {
      Future<PermissionStatus> status = event.src == ImageSource.gallery
          ? permissionUtils.askCameraPermission(Permission.storage)
          : permissionUtils.askCameraPermission(Permission.camera);

      if (await status.isDenied) {
        emit(state.copyWith(isDenied: true));
      } else if (await status.isPermanentlyDenied) {
        emit(state.copyWith(isDenied: false, isPermanentDenied: true));
      } else if (await status.isGranted) {
        video = await getVideRepo.pickVideo(event.src);
        thumbImg = await getVideRepo.getThumbNail();
        emit(state.copyWith(
          isDenied: false,
          isPermanentDenied: false,
          thumbnailImg: thumbImg!,
          video: video!,
          play: true,
        ));
      }
    } catch (e) {
      emit(state.copyWith(play: false));
    }
  }
}
