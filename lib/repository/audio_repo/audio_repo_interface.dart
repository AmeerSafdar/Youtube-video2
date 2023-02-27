import 'package:audioplayers/audioplayers.dart';

abstract class AudioInterface {
  Future<AudioPlayer?> pickAudio();
  void play();
  Future<List> pickPosition();
  void pause();
}
