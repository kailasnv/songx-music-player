import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state_managment/songs_bloc/songs_bloc.dart';
import '../../../widgets/songtile.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.favoritePlaylist.isNotEmpty) {
          return ListView.builder(
            itemCount: state.favoritePlaylist.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // this [song] will get me each individual songs
              final song = state.favoritePlaylist[index];

              return SongTileWidget(song: song, index: index);
            },
          );
        } else {
          return const Center(child: Text("No Fav Songs Found."));
        }
      },
    );
  }
}
