import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state_managment/theme_state/theme_cubit.dart';

class CustomAppbar extends StatelessWidget {
  final bool isDarkTheme;
  const CustomAppbar({
    super.key,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("SongX",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          )),
      actions: [
        // update theme mode button
        IconButton(
          onPressed: () {
            context.read<ThemeCubit>().updataTheme();
          },
          icon: Icon(isDarkTheme ? Icons.light : Icons.dark_mode_outlined),
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        /*// open settings button
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        // */
      ],
      // bottom
      bottom: const TabBar(
        tabs: [
          Tab(text: "Tracks"),
          Tab(text: "Artists"),
          Tab(text: "Albums"),
          Tab(text: "Playlists"),
        ],
      ),
      // */
    );
  }
}
