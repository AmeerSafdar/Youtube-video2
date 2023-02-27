// ignore_for_file: depend_on_referenced_packages, use_rethrow_when_possible, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task009/blocs/image_bloc/image_bloc_events.dart';
import 'package:task009/blocs/image_bloc/image_bloc_states.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/repository/image_repo/image_repository.dart';

class ImageBloc extends Bloc<GetImage, ImageStates> {
  ImageRepository imgRepo;
  File? data;

  ImageBloc({required this.imgRepo}) : super(ImageStates()) {
    on<FetchImage>(_retrieveImage);
  }

  void _retrieveImage(FetchImage event, Emitter<ImageStates> emit) async {
    Future<PermissionStatus> status = event.imgSrc == ImageSource.gallery
        ? permissionUtils.askCameraPermission(Permission.storage)
        : permissionUtils.askCameraPermission(Permission.camera);
    try {
      if (await status.isDenied) {
        emit(state.copyWith(denied: true));
      }

      if (await status.isPermanentlyDenied) {
        emit(state.copyWith(permanent_denied: true, denied: false));
      } else if (await status.isGranted) {
        data = await imgRepo.pickImage(event.imgSrc);
        emit(
            state.copyWith(img: data!, denied: false, permanent_denied: false));
      }
    } catch (e) {
      emit(state.copyWith(permanent_denied: false, img: data));
    }
  }
}
