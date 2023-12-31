import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/pages/homepage/widgets/favorite.dart';
import 'package:songx/presentation/pages/homepage/widgets/tracks.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';

import '../../../domain/repo/permission.dart';
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
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    requestStoragePermission(_audioQuery).then((value) {
      //after getting permission, call events
      // get all tracks from mobile storage
      BlocProvider.of<SongsBloc>(context)
          .add(FetchAllSongsEvent(audioQuery: _audioQuery));

      // init the audio player
      Provider.of<AudioProvider>(context, listen: false).initMyAudioPlayer();

      // get all favorite songs from hive db
      BlocProvider.of<SongsBloc>(context).add(FetchFavoritePlaylistEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<AudioProvider>(context, listen: false).dispose();
    super.dispose();
  }

  // list of all 4 page
  static const List<Widget> categories = [
    TracksPage(),
    FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // print("home page build called..");

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
