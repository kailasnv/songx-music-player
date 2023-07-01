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
    var prov = Provider.of<AudioProvider>(context, listen: false);

    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        //  color: isDarkTheme
        //      ? Colors.black
        //      : Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColor),
        ),

        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.2),
              Colors.black,
            ]),
      ),
      child: Row(
        children: [
          // song  thumbnail & name showing - small section
          Expanded(
            child: BlocBuilder<SongsBloc, SongsState>(
              builder: (context, state) {
                if (state.currentSong != null) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: QueryArtworkWidget(
                          id: state.currentSong!.id,
                          type: ArtworkType.AUDIO,
                          artworkFit: BoxFit.contain,
                          artworkBorder: BorderRadius.zero,
                        ),
                      ),
                      // name
                      Expanded(
                          child: SizedBox(
                              child: Text(
                        state.currentSong!.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ))),
                    ],
                  );
                } else {
                  return const Center(child: Text("Play any Song you like"));
                }
              },
            ),
          ),

          // PREVIOUS SONG
          IconButton(
            onPressed: () => context
                .read<SongsBloc>()
                .add(PlayPreviousSong(audioPlayer: prov.audioPlayer)),
            icon: const Icon(Icons.skip_previous_outlined),
          ),
          // PLAY OR PAUSE
          BlocBuilder<SongsBloc, SongsState>(
            builder: (context, state) => IconButton(
                onPressed: () {
                  context
                      .read<SongsBloc>()
                      .add(PlayPauseSong(audioPlayer: prov.audioPlayer));
                },
                icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow)),
          ),
          //NEXT SONG
          IconButton(
            onPressed: () => context
                .read<SongsBloc>()
                .add(PlayNextSong(audioPlayer: prov.audioPlayer)),
            icon: const Icon(Icons.skip_next_outlined),
          ),
        ],
      ),
    );
  }
}
