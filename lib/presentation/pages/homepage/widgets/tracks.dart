import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:songx/presentation/state_managment/songs_bloc/songs_bloc.dart';

import '../../../widgets/songtile.dart';

class TracksPage extends StatelessWidget {
  const TracksPage({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.allTracksPlaylist != null) {
          return ListView.builder(
            itemCount: state.allTracksPlaylist!.length,
            itemBuilder: (context, index) {
              // this [song] will get me each individual songs
              final song = state.allTracksPlaylist![index];

              return SongTileWidget(song: song, index: index);
            },
          );
        } else {
          return const Center(child: Text("No Songs Found."));
        }
      },
    );
  }
}
