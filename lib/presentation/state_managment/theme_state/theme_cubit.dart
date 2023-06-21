import 'package:bloc/bloc.dart';
//import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(isDarkModeOn: false));

  // change theme method
  void updataTheme() {
    emit(ThemeState(isDarkModeOn: !state.isDarkModeOn));
  }
}