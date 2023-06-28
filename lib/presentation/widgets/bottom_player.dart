import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songx/presentation/pages/player_page/player_screen.dart';
import 'package:songx/presentation/state_managment/theme_state/theme_cubit.dart';

class BottomNowPlayingTile extends StatelessWidget {
  const BottomNowPlayingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        Color color = state.isDarkModeOn ? Colors.black : Colors.white;

        return Container(
          width: double.infinity,
          height: 60,
          color: color,
          child: Row(
            children: [
              // song  thumbnail & name showing - small section
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PlayerScreen(),
                  ));
                },
                child: Container(color: Colors.red.withOpacity(0.5)),
              )),

              // play pause next previous part
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.skip_next_outlined)),
            ],
          ),
        );
      },
    );
  }
}
