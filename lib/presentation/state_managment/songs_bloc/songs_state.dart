part of 'songs_bloc.dart';

class SongsState {
  final bool isLoading;
  final List<SongModel>? songModalList;
  final SongModel? previousSong;
  final bool isPlaying;

  SongsState({
    required this.isLoading,
    this.songModalList,
    this.previousSong,
    required this.isPlaying,
  });
}

class SongsInitial extends SongsState {
  SongsInitial({required super.isLoading, required super.isPlaying});
}
