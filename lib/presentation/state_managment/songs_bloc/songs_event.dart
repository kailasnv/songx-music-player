part of 'songs_bloc.dart';

class SongsEvent {}

class FetchAllSongsEvent extends SongsEvent {
  final OnAudioQuery audioQuery;
  FetchAllSongsEvent({required this.audioQuery});
}

// play tapped song
class GetCurrentSongEvent extends SongsEvent {
  final SongModel currentSong;
  final AudioPlayer audioPlayer;
  final int songIndex;

  GetCurrentSongEvent({
    required this.currentSong,
    required this.audioPlayer,
    required this.songIndex,
  });
}

class PlayPauseSong extends SongsEvent {
  final AudioPlayer audioPlayer;
  PlayPauseSong({required this.audioPlayer});
}

class PlayNextSong extends SongsEvent {
  final AudioPlayer audioPlayer;
  PlayNextSong({required this.audioPlayer});
}

class PlayPreviousSong extends SongsEvent {
  final AudioPlayer audioPlayer;
  PlayPreviousSong({required this.audioPlayer});
}
