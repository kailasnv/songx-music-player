import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel? songModal;
  const PlayerScreen({super.key, this.songModal});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      //
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // song thumbnail
            Container(
              height: size.height * 0.4,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: songModal != null
                  ? QueryArtworkWidget(
                      id: songModal!.id,
                      type: ArtworkType.AUDIO,
                    )
                  : const Text("no image"),
            ),
            // song progres slider

            // song title , artists name

            // play pause actions

            // add to fav
          ],
        ),
      ),
    );
  }
}
