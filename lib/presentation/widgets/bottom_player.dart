import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/pages/player_page/player_screen.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../../utils/slide_page_route.dart';
import '../state_managment/songs_bloc/songs_bloc.dart';

class BottomNowPlayingTile extends StatelessWidget {
  final bool isDarkTheme;
  const BottomNowPlayingTile({super.key, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AudioProvider>(context, listen: false);

    return BlocBuilder<SongsBloc, SongsState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          // go to song player page
          if (state.currentSong != null) {
            Navigator.of(context).push(
              SlidePageRoute(child: const PlayerScreen()),
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Theme.of(context).primaryColor)),
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
                              keepOldArtwork: true,
                              artworkFit: BoxFit.contain,
                              artworkBorder: BorderRadius.zero,
                              nullArtworkWidget: const SizedBox(),
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
                      return const Center(
                          child: Text("Play any Song you like"));
                    }
                  },
                ),
              ),
              /*             - SONGS EVENTS -             */
              // PREVIOUS SONG
              IconButton(
                onPressed: () => context
                    .read<SongsBloc>()
                    .add(PlayPreviousSong(audioPlayer: prov.audioPlayer)),
                icon: const Icon(Icons.skip_previous_outlined),
              ),
              // PLAY OR PAUSE
              IconButton(
                  onPressed: () {
                    // checking this for - Not to call event if there is no current song
                    if (state.currentSong != null) {
                      context
                          .read<SongsBloc>()
                          .add(PlayPauseSong(audioPlayer: prov.audioPlayer));
                    }
                  },
                  icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow)),
              //NEXT SONG
              IconButton(
                onPressed: () => context
                    .read<SongsBloc>()
                    .add(PlayNextSong(audioPlayer: prov.audioPlayer)),
                icon: const Icon(Icons.skip_next_outlined),
              ),
            ],
          ),
        ),
      );
    });
  }
}
