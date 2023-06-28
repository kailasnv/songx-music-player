import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Repositary {
  static Future<List<SongModel>> getAllSongsFromDevice(
      OnAudioQuery audioQuery) async {
    final List<SongModel> songs;

    songs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    return songs;
  }

  // play the current tapped song
  // instance of audioplayer

  Future<void> playCurrentSong(AudioPlayer audioPlayer, String songUrl) async {
    // set audio
    // play audio
  }
  Future<void> pauseCurrentSong(AudioPlayer audioPlayer) async {
    // pause audio
  }
}
