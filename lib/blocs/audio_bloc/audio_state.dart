import 'package:audioplayers/audioplayers.dart';

class AudioStates {
  AudioStates(
      {this.isDenied,
      this.isPermanentlyDenied,
      this.audio,
      this.duration,
      this.position,
      this.play});
  AudioPlayer? audio;
  Duration? duration;
  Duration? position;
  bool? play;
  bool? isDenied;
  bool? isPermanentlyDenied;
  AudioStates copyWith(
      {bool? isDenied,
      bool? isPermanentlyDenied,
      AudioPlayer? audio,
      Duration? duration,
      Duration? position,
      bool? play}) {
    return AudioStates(
        audio: audio ?? this.audio,
        isDenied: isDenied ?? this.isDenied,
        isPermanentlyDenied: isPermanentlyDenied ?? this.isPermanentlyDenied,
        duration: duration ?? this.duration,
        position: position ?? this.position,
        play: play ?? this.play);
  }
}
