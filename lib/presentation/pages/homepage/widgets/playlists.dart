import 'package:flutter/material.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // fav songs list

          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Center(
                  child: Row(
                children: const [
                  Text("Favorite Songs",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ],
              )),
            ),
          ),

          // recent played songs list
          HeadingTitleWidget(
            title: "Recent Played Songs",
            canShowMoreButton: false,
            onTap: () {},
          ),
          // Consumer<Database>(
          //   builder: (context, state, _) {
          //     if (state.favoriteSongList.isNotEmpty) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemCount: state.favoriteSongList.length,
          //         itemBuilder: (context, index) {
          //           var song = state.favoriteSongList[index];

          //           return ListTile(title: Text(song.title));
          //         },
          //       );
          //     } else {
          //       return const Text("No Recent Songs.");
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
    required this.title,
  });

  final String title;
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
            Text(title, style: style),
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
