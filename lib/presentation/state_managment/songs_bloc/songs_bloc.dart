import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:songx/domain/repo/fetchsongs_repo.dart';
import 'package:just_audio/just_audio.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc() : super(SongsInitial(isLoading: false)) {
    // get songs from device storage
    on<FetchAllSongsEvent>((event, emit) async {
      emit(SongsState(isLoading: true));

      final songs = await Repositary.getAllSongsFromDevice(event.audioQuery);

      emit(SongsState(isLoading: false, songModalList: songs));
    });

    //
    on<GetCurrentSongEvent>((event, emit) async {
      SongsState(
        isLoading: false,
        songModalList: state.songModalList,
        currentSong: event.currentSong,
      );

      print("current song data : ${state.currentSong!.data}");
    });
  }
}
