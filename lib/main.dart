import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songx/presentation/pages/homepage/home_screen.dart';
import 'package:songx/presentation/state_managment/theme_state/theme_cubit.dart';
import 'package:songx/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
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
