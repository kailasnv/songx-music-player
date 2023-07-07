import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../../state_managment/songs_bloc/songs_bloc.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final prov = Provider.of<AudioProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(child: BlocBuilder<SongsBloc, SongsState>(
        builder: (context, state) {
          if (state.currentSong != null) {
            return Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.center,
                children: [
                  // just for a gradient shade
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Theme.of(context).scaffoldBackgroundColor,
                          Colors.black,
                        ])),
                  ),
                  //  a shade of song image as background
                  Opacity(
                    opacity: 0.2,
                    child: _buildSongImageBox(size, state, context),
                  ),
                  // blur effect
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container()),

                  // MAIN contents or Main Column
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Back arrrow buttons
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                size: 45),
                          ),
                        ),
                        // song thumbnail box
                        _buildSongImageBox(size, state, context),

                        // song title , artists name
                        Container(
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            Text(state.currentSong!.title,
                                textAlign: TextAlign.center,
                                style: boldStyle(25)),
                            const SizedBox(height: 8),
                            Text(state.currentSong!.artist.toString(),
                                textAlign: TextAlign.center,
                                style: boldStyle(10)),
                          ]),
                        ),
                        // song progres slider  TODO :
                        const Divider(
                          thickness: 3,
                          color: Colors.white,
                          indent: 15,
                          endIndent: 15,
                        ),
                        // play pause action buttons

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // shuffle songs button

                              // PREVIOUS SONG
                              IconButton(
                                  onPressed: () => context
                                      .read<SongsBloc>()
                                      .add(PlayPreviousSong(
                                          audioPlayer: prov.audioPlayer)),
                                  icon: const Icon(
                                    Icons.skip_previous_outlined,
                                    color: Colors.white,
                                  )),
                              // PLAY OR PAUSE
                              CircleAvatar(
                                child: IconButton(
                                    onPressed: () {
                                      //calling event
                                      context.read<SongsBloc>().add(
                                          PlayPauseSong(
                                              audioPlayer: prov.audioPlayer));
                                    },
                                    icon: Icon(
                                      state.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    )),
                              ),
                              //NEXT SONG
                              IconButton(
                                  onPressed: () => context
                                      .read<SongsBloc>()
                                      .add(PlayNextSong(
                                          audioPlayer: prov.audioPlayer)),
                                  icon: const Icon(
                                    Icons.skip_next_outlined,
                                    color: Colors.white,
                                  )),

                              // Heart button - add song to fav
                            ]),
                        const SizedBox(height: 50),
                      ]),
                ]);
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }

  TextStyle boldStyle(double size) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: Colors.white,
    );
  }

  Container _buildSongImageBox(
      Size size, SongsState state, BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 30,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
      ]),
      child: QueryArtworkWidget(
        artworkHeight: size.height * 0.4,
        artworkWidth: size.width * 0.8,
        id: state.currentSong!.id,
        type: ArtworkType.AUDIO,
        artworkFit: BoxFit.cover,
        artworkBorder: BorderRadius.circular(10),
        nullArtworkWidget: _noThumbNailBox(size, context),
      ),
    );
  }

  Container _noThumbNailBox(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.4,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: const Center(child: Icon(Icons.music_note_outlined, size: 45)),
    );
  }
}
