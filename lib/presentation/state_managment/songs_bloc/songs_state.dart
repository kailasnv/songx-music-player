part of 'songs_bloc.dart';

class SongsState {
  final bool isLoading;
  final List<SongModel>? songModalList;
  final SongModel? currentSong;
  final bool isPlaying;
  final int? songIndex;

  SongsState({
    required this.isLoading,
    this.songModalList,
    this.currentSong,
    required this.isPlaying,
    this.songIndex,
  });
}

class SongsInitial extends SongsState {
  SongsInitial({required super.isLoading, required super.isPlaying});
}
