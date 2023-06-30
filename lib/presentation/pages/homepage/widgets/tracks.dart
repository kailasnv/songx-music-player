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
        if (state.songModalList != null) {
          return ListView.builder(
            itemCount: state.songModalList!.length,
            itemBuilder: (context, index) {
              // this [song] will get me each individual songs
              final song = state.songModalList![index];

              return SongTileWidget(song: song);
            },
          );
        } else {
          return const Center(child: Text("No Songs Found."));
        }
      },
    );
  }
}
