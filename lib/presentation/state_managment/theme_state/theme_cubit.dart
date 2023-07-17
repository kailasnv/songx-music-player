import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final bool lastTheme;
  ThemeCubit({required this.lastTheme})
      : super(ThemeInitial(isDarkModeOn: lastTheme));

  final myThemeBox = Hive.box("theme");

  // change theme method
  void updataTheme() {
    emit(ThemeState(isDarkModeOn: !state.isDarkModeOn));
    myThemeBox.put("THEME_KEY", state.isDarkModeOn);
  }
}
