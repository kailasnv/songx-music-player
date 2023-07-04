import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // grid of recent playlist  / show more or show less button

          // recent played songs
          HeadingTitleWidget(
            canShowMoreButton: false,
            onTap: () {},
          ),
          // BlocBuilder<PlaylistBloc, PlaylistState>(
          //   builder: (context, state) {
          //     if (state.recentPlaylist.isNotEmpty) {
          //       return ListView.builder(
          //         itemCount: state.recentPlaylist.length,
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           final song = state.recentPlaylist[index];

          //           return ListTile(
          //             title: Text(song.title),
          //             subtitle: Text(song.data),
          //           );
          //         },
          //       );
          //     } else {
          //       return const Center(child: Text("No recent songs"));
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

class HeadingTitleWidget extends StatelessWidget {
  const HeadingTitleWidget({
    super.key,
    required this.canShowMoreButton,
    required this.onTap,
  });
  final bool canShowMoreButton;
  final void Function()? onTap;
  static const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Opacity(
        opacity: 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recent Played Songs", style: style),
            canShowMoreButton
                ? GestureDetector(
                    onTap: onTap,
                    child: const Text("Show All", style: style),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
