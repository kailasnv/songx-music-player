import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../state_managment/songs_bloc/songs_bloc.dart';

class BottomNowPlayingTile extends StatelessWidget {
  final bool isDarkTheme;
  const BottomNowPlayingTile({super.key, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.black
            : Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Row(
        children: [
          // song  thumbnail & name showing - small section
          Expanded(
            child: BlocBuilder<SongsBloc, SongsState>(
              builder: (context, state) {
                if (state.previousSong != null) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: QueryArtworkWidget(
                          id: state.previousSong!.id,
                          type: ArtworkType.AUDIO,
                          artworkFit: BoxFit.contain,
                          artworkBorder: BorderRadius.zero,
                        ),
                      ),
                      // name
                      Expanded(
                          child: SizedBox(
                              child: Text(
                        state.previousSong!.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Play Your Fav Song"),
                  );
                }
              },
            ),
          ),

          // play pause next previous part // TODO :
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.skip_previous_outlined)),

          BlocBuilder<SongsBloc, SongsState>(
            builder: (context, state) => IconButton(
                onPressed: () {
                  var prov = Provider.of<AudioProvider>(context, listen: false);
                  context
                      .read<SongsBloc>()
                      .add(PlayPauseSong(audioPlayer: prov.audioPlayer));
                },
                icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow)),
          ),

          IconButton(
              onPressed: () {}, icon: const Icon(Icons.skip_next_outlined)),
        ],
      ),
    );
  }
}
