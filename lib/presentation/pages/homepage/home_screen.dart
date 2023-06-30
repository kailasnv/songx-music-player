import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/pages/homepage/widgets/albums.dart';
import 'package:songx/presentation/pages/homepage/widgets/artists.dart';
import 'package:songx/presentation/pages/homepage/widgets/playlists.dart';
import 'package:songx/presentation/pages/homepage/widgets/tracks.dart';
import 'package:just_audio/just_audio.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../../../utils/permission.dart';
import '../../state_managment/songs_bloc/songs_bloc.dart';
import '../../widgets/appbar.dart';
import '../../widgets/bottom_player.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkTheme;
  const HomeScreen({super.key, required this.isDarkTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  //instance of OnAudioQuery class
  late final OnAudioQuery _audioQuery;

  @override
  void initState() {
    _audioQuery = OnAudioQuery();
    requestStoragePermission(_audioQuery);
    BlocProvider.of<SongsBloc>(context)
        .add(FetchAllSongsEvent(audioQuery: _audioQuery));
    // init the audio player
    Provider.of<AudioProvider>(context, listen: false).initMyAudioPlayer();
    super.initState();
  }

  // list of all 4 page
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
          child: CustomAppbar(isDarkTheme: widget.isDarkTheme),
        ),
        body: const TabBarView(children: categories),

        // bottom player

        bottomNavigationBar:
            BottomNowPlayingTile(isDarkTheme: widget.isDarkTheme),
      ),
    );
  }
}
