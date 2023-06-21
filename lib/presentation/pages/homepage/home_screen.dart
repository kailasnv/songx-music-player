import 'package:flutter/material.dart';
import 'package:songx/presentation/pages/homepage/widgets/albums.dart';
import 'package:songx/presentation/pages/homepage/widgets/artists.dart';
import 'package:songx/presentation/pages/homepage/widgets/playlists.dart';
import 'package:songx/presentation/pages/homepage/widgets/tracks.dart';

import '../../widgets/appbar.dart';
import '../../widgets/bottom_player.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkTheme;
  const HomeScreen({super.key, required this.isDarkTheme});

  static const List<Widget> categories = [
    TracksPage(),
    ArtistsPage(),
    AlbumsPage(),
    PlaylistsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    print("home page build called..");

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppbar(isDarkTheme: isDarkTheme),
        ),
        body: const TabBarView(children: categories),
        // bottom player
        extendBody: true,
        bottomSheet: const BottomSongPlayer(),
      ),
    );
  }
}
