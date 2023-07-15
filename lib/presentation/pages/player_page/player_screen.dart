import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../../state_managment/songs_bloc/songs_bloc.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final prov = Provider.of<AudioProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: [
              //this Container is for just for a gradient shade
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
              //  a image of current playing song  as background
              Opacity(
                opacity: 0.2,
                child: _buildSongImageBox(size, context),
              ),
              // blur effect
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container()),

              // MAIN contents of page   or Main Column
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Back arrrow button / POP page
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 45)),
                    ),
                    // Cover image of song
                    _buildSongImageBox(size, context),

                    // song title , artists name
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: BlocBuilder<SongsBloc, SongsState>(
                        builder: (context, state) {
                          if (state.currentSong != null) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(state.currentSong!.title,
                                              style: boldStyle(25)),
                                          const SizedBox(height: 8),
                                          Text(
                                              state.currentSong!.artist
                                                  .toString(),
                                              style: boldStyle(10)),
                                        ]),
                                  ),
                                ),
                                // Heart button - add song to fav
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<SongsBloc>()
                                          .add(AddToFavEvent(
                                            currentSong: state.currentSong!,
                                            context: context,
                                          ));
                                    },
                                    icon: Icon(
                                      state.favoritePlaylist
                                              .contains(state.currentSong)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                    )),
                              ],
                            );
                          } else {
                            return const Text("No song available");
                          }
                        },
                      ),
                    ),
                    // song progres slider
                    StreamBuilder(
                      stream: prov.positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ProgressBar(
                            progress: positionData?.position ?? Duration.zero,
                            buffered: positionData?.position ?? Duration.zero,
                            total: positionData?.duration ?? Duration.zero,
                            onSeek: prov.audioPlayer.seek,
                            // apperance
                            barHeight: 3,
                            progressBarColor: Colors.white,
                            thumbColor: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    ),

                    //   THE 3 SONG EVENTS
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // PREVIOUS SONG
                          IconButton(
                              onPressed: () => context.read<SongsBloc>().add(
                                  PlayPreviousSong(
                                      audioPlayer: prov.audioPlayer)),
                              icon: const Icon(
                                Icons.skip_previous_outlined,
                                color: Colors.white,
                              )),
                          // PLAY OR PAUSE
                          CircleAvatar(
                              radius: 30,
                              child: BlocBuilder<SongsBloc, SongsState>(
                                builder: (context, state) {
                                  return IconButton(
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
                                      ));
                                },
                              )),
                          //NEXT SONG
                          IconButton(
                              onPressed: () => context.read<SongsBloc>().add(
                                  PlayNextSong(audioPlayer: prov.audioPlayer)),
                              icon: const Icon(
                                Icons.skip_next_outlined,
                                color: Colors.white,
                              )),
                        ]),
                    const SizedBox(height: 50),
                  ]),
            ]),
      ),
    );
  }

  TextStyle boldStyle(double size) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: Colors.white,
    );
  }

  BlocBuilder _buildSongImageBox(Size size, BuildContext context) {
    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        if (state.currentSong != null) {
          return Container(
            height: size.height * 0.4,
            width: size.width * 0.8,
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
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(10),
              nullArtworkWidget: _noThumbNailBox(size, context),
            ),
          );
        } else {
          return _noThumbNailBox(size, context);
        }
      },
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
