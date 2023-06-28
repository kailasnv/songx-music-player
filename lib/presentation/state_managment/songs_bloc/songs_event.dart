part of 'songs_bloc.dart';

class SongsEvent {}

class FetchAllSongsEvent extends SongsEvent {
  final OnAudioQuery audioQuery;
  FetchAllSongsEvent({required this.audioQuery});
}

// play tapped song
class GetCurrentSongEvent extends SongsEvent {
  final AudioPlayer audioPlayer;
  final SongModel currentSong;

  GetCurrentSongEvent({required this.currentSong, required this.audioPlayer});
}
