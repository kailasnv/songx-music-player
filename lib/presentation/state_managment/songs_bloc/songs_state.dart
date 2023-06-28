part of 'songs_bloc.dart';

class SongsState {
  final bool isLoading;
  final List<SongModel>? songModalList;
  final SongModel? currentSong;

  SongsState({
    required this.isLoading,
    this.songModalList,
    this.currentSong,
  });
}

class SongsInitial extends SongsState {
  SongsInitial({required super.isLoading});
}
