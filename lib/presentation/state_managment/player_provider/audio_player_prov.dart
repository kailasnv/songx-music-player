import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  late final AudioPlayer _audioPlayer;
  AudioPlayer get audioPlayer => _audioPlayer;

  void initMyAudioPlayer() {
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
