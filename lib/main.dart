import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:songx/presentation/pages/homepage/home_screen.dart';
import 'package:songx/presentation/state_managment/player_provider/audio_player_prov.dart';
import 'package:songx/presentation/state_managment/songs_bloc/songs_bloc.dart';
import 'package:songx/presentation/state_managment/theme_state/theme_cubit.dart';
import 'package:songx/utils/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize hive
  await Hive.initFlutter();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AudioProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()), // manages theme
        BlocProvider(create: (context) => SongsBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'songx',
            theme: AppTheme.themedata(state.isDarkModeOn),
            home: HomeScreen(isDarkTheme: state.isDarkModeOn),
          );
        },
      ),
    );
  }
}
