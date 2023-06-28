import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:songx/presentation/state_managment/songs_bloc/songs_bloc.dart';

class TracksPage extends StatefulWidget {
  const TracksPage({super.key});

  @override
  State<TracksPage> createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {
  //
  // instance of audioPlayer
  late AudioPlayer audioPlayer;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    super.initState();
  }

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

              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.artist!),
                onTap: () async {
                  await audioPlayer.setAudioSource(AudioSource.file(song.data));

                  if (!audioPlayer.playing) {
                    await audioPlayer.play();
                  } else {
                    await audioPlayer.pause();
                  }
                },
              );
            },
          );
        } else {
          return const Center(child: Text("No Songs Found."));
        }
      },
    );
  }
}
