import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../state_managment/songs_bloc/songs_bloc.dart';

class SongTileWidget extends StatelessWidget {
  const SongTileWidget({
    super.key,
    required this.song,
    required this.index,
  });

  final SongModel song;
  final int index;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AudioProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: GestureDetector(
        onTap: () {
          //  play or pause the song which is tapped right now
          context.read<SongsBloc>().add(GetCurrentSongEvent(
                currentSong: song,
                audioPlayer: state.audioPlayer,
                songIndex: index,
              ));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              // artist
              Row(children: [
                Expanded(
                    child: SizedBox(
                  child: Text(song.artist ?? "",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      )),
                )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
