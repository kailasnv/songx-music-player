part of 'playlist_bloc.dart';

class PlaylistState {
  final List<int>? recentPlayedSongsID;

  const PlaylistState({
    this.recentPlayedSongsID,
  });
}

class PlaylistInitial extends PlaylistState {}
