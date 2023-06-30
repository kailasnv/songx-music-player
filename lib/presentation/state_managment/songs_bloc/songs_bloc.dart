import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:songx/domain/repo/fetchsongs_repo.dart';
import 'package:just_audio/just_audio.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc() : super(SongsInitial(isLoading: false, isPlaying: false)) {
    // get all songs from device storage
    on<FetchAllSongsEvent>((event, emit) async {
      emit(SongsState(
        isLoading: true,
        isPlaying: false,
      ));

      final songs = await Repositary.getAllSongsFromDevice(event.audioQuery);

      emit(SongsState(
        isLoading: false,
        songModalList: songs, //update the list of songs
        isPlaying: false,
      ));
    });

    //
    on<PlayCurrentSongEvent>((event, emit) async {
      var audioPlayer = event.audioPlayer;
      // play or pause methods
      if (!audioPlayer.playing) {
        // uf NOT playing ,
        emit(SongsState(
          isLoading: false,
          previousSong: event.currentSong, // updating previous song
          songModalList: state.songModalList,
          isPlaying: true,
        ));
        // sets file to audioplayer  , then play the song..
        await audioPlayer
            .setAudioSource(AudioSource.file(event.currentSong.data));
        await audioPlayer.play();
      }

      // if already playing........... ,
      if (audioPlayer.playing) {
        // checking if the user tapped the same song   or a new song
        if (event.currentSong == state.previousSong) {
          // if user tapped same song then pause the song

          emit(SongsState(
            isLoading: false,
            previousSong: event.currentSong, // updating previous song
            songModalList: state.songModalList,
            isPlaying: false,
          ));
          await audioPlayer.pause(); // pause
        } else {
          // if user tapped a NEW song then play the new song
          emit(SongsState(
            isLoading: false,
            previousSong: event.currentSong, // updating previous song
            songModalList: state.songModalList,
            isPlaying: true,
          ));
          // Play new song
          await audioPlayer
              .setAudioSource(AudioSource.file(event.currentSong.data));
          await audioPlayer.play();
        }
      }
    });

    // play and pause
    on<PlayPauseSong>((event, emit) async {
      var audioPlayer = event.audioPlayer;

      if (audioPlayer.playing) {
        // before pause or play, I need to update the state
        emit(SongsState(
          isLoading: false,
          isPlaying: false,
          previousSong: state.previousSong,
          songModalList: state.songModalList,
        ));
        await audioPlayer.pause();
      } else {
        emit(SongsState(
          isLoading: false,
          isPlaying: true,
          previousSong: state.previousSong,
          songModalList: state.songModalList,
        ));
        await audioPlayer.play();
      }
    });
  }
}
