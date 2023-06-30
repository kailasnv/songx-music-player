part of 'songs_bloc.dart';

class SongsEvent {}

class FetchAllSongsEvent extends SongsEvent {
  final OnAudioQuery audioQuery;
  FetchAllSongsEvent({required this.audioQuery});
}

// play tapped song
class PlayCurrentSongEvent extends SongsEvent {
  final SongModel currentSong;
  final AudioPlayer audioPlayer;

  PlayCurrentSongEvent({required this.currentSong, required this.audioPlayer});
}

class PlayNextSong extends SongsEvent {}

class PlayPreviousSong extends SongsEvent {}

class PlayPauseSong extends SongsEvent {
  final AudioPlayer audioPlayer;
  PlayPauseSong({required this.audioPlayer});
}
