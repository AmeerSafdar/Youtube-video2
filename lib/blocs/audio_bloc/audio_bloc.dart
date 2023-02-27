// ignore_for_file: unused_element, use_rethrow_when_possible, prefer_const_constructors, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task009/blocs/audio_bloc/audio_events.dart';
import 'package:task009/blocs/audio_bloc/audio_state.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/repository/audio_repo/audio_reposirty_implements.dart';

class AudioBlocs extends Bloc<GetAudio, AudioStates> {
  AudioRepository audioRepo = AudioRepository();
  AudioPlayer? data;
  List<dynamic>? length;
  AudioBlocs({required this.audioRepo}) : super(AudioStates()) {
    on<FetchAudio>(_fetchAudio);
    on<GetDuration>(_getDuration);
    on<Play>(_play);
    on<Pause>(_pause);
    on<Drag>(_drag);
  }

  void _drag(Drag event, Emitter<AudioStates> emit) {
    length![1] = event.duration;
    emit(state.copyWith(
        play: true,
        position: length![1],
        duration: length!.elementAt(0),
        audio: data));
  }

  Future<void> _play(Play event, Emitter<AudioStates> emitt) async {
    audioRepo.play();
    emit(state.copyWith(play: true));
  }

  Future<void> _pause(Pause event, Emitter<AudioStates> emit) async {
    audioRepo.pause();
    length = await audioRepo.pickPosition();
    emit(state.copyWith(play: false));
  }

  Future<void> _getDuration(
      GetDuration event, Emitter<AudioStates> emit) async {
    try {
      length = await audioRepo.pickPosition();
      emit(state.copyWith(
          isPermanentlyDenied: false,
          isDenied: false,
          audio: length!.elementAt(2),
          duration: length!.elementAt(0),
          position: length!.elementAt(1)));
    } catch (e) {
      throw e;
    }
  }

  Future<void> _fetchAudio(FetchAudio event, Emitter<AudioStates> emit) async {
    try {
      Future<PermissionStatus> status =
          permissionUtils.askCameraPermission(Permission.storage);
      if (await status.isDenied) {
        emit(state.copyWith(isDenied: true));
      } else if (await status.isPermanentlyDenied) {
        emit(state.copyWith(
          isDenied: false,
          isPermanentlyDenied: true,
        ));
      } else if (await status.isGranted) {
        data = await audioRepo.pickAudio();
        length = await audioRepo.pickPosition();
        emit(state.copyWith(
            play: true,
            isDenied: false,
            isPermanentlyDenied: false,
            duration: length!.elementAt(0),
            position: length!.elementAt(1)));
      }
    } catch (e) {
      emit(state.copyWith(
          duration: length?.elementAt(0), position: length?.elementAt(1)));
    }
  }
}
