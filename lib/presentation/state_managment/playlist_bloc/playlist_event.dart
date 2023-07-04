part of 'playlist_bloc.dart';

class PlaylistEvent {}

class AddToRecentEvent extends PlaylistEvent {
  final SongModel currentSong;
  AddToRecentEvent({required this.currentSong});
}
