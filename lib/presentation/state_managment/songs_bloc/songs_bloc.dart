import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:songx/domain/repo/fetchsongs_repo.dart';
import 'package:just_audio/just_audio.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc() : super(SongsInitial(isLoading: false, isPlaying: false)) {
    // GET ALL SONGS from device storage
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

    // GET  CURRENT TAPPED SONG and PLAY THE SONG - ( also can pause the song )
    on<GetCurrentSongEvent>((event, emit) async {
      var audioPlayer = event.audioPlayer;

      if (!audioPlayer.playing) {
        // if NOT playing , iam going to play it
        emit(SongsState(
          isLoading: false,
          currentSong: event.currentSong, // updating current song
          songModalList: state.songModalList,
          isPlaying: true, // before play method , updating this to true
          songIndex: event.songIndex,
        ));
        // sets file to audioplayer  , then play the song..
        await audioPlayer
            .setAudioSource(AudioSource.file(event.currentSong.data));
        await audioPlayer.play();
      }

      // if already playing........... ,
      if (audioPlayer.playing) {
        // checking if the user tapped the same song   or a new song
        if (event.currentSong == state.currentSong) {
          // if user tapped same song - then PAUSE the song

          emit(SongsState(
            isLoading: false,
            currentSong:
                event.currentSong, // updating current song drom user event
            songModalList: state.songModalList,
            isPlaying: false,
            songIndex: state.songIndex,
          ));
          await audioPlayer.pause(); // pause
        } else {
          // if user tapped a NEW song then play the new song
          emit(SongsState(
            isLoading: false,
            currentSong: event.currentSong, // updating current song
            songModalList: state.songModalList,
            isPlaying: true,
            songIndex: event.songIndex,
          ));
          // set up a NEW audio file and  PLAY the new song
          await audioPlayer
              .setAudioSource(AudioSource.file(event.currentSong.data));
          await audioPlayer.play();
        }
      }
    });

    // play and pause event
    on<PlayPauseSong>((event, emit) async {
      var audioPlayer = event.audioPlayer;

      if (audioPlayer.playing) {
        // before pause or play, I need to update the isPlaying state
        emit(SongsState(
          isLoading: false,
          isPlaying: false,
          currentSong: state.currentSong,
          songModalList: state.songModalList,
          songIndex: state.songIndex,
        ));
        await audioPlayer.pause();
      } else {
        emit(SongsState(
          isLoading: false,
          isPlaying: true,
          currentSong: state.currentSong,
          songModalList: state.songModalList,
          songIndex: state.songIndex,
        ));
        await audioPlayer.play();
      }
    });

    // skip to NEXT song event
    on<PlayNextSong>((event, emit) async {
      final audioPlayer = event.audioPlayer;
      if (state.songIndex != null) {
        emit(SongsState(
          isLoading: false,
          isPlaying: state.isPlaying,
          songModalList: state.songModalList,
          currentSong: state.songModalList![
              state.songIndex! + 1], // updating current song by +1
          songIndex: state.songIndex! + 1, //also updating song index by + 1
        ));

        // set up a NEXT audio file and  PLAY the Next song
        await audioPlayer
            .setAudioSource(AudioSource.file(state.currentSong!.data));
        await audioPlayer.play();
      }
    });

    // skip to PREVIOUS song event
    on<PlayPreviousSong>((event, emit) async {
      var audioPlayer = event.audioPlayer;

      if (state.songIndex != null) {
        emit(SongsState(
          isLoading: false,
          isPlaying: state.isPlaying,
          songModalList: state.songModalList,
          currentSong: state.songModalList![state.songIndex! - 1],
          songIndex: state.songIndex! - 1,
        ));

        // set up a PREVIOUS audio file and  PLAY the previous song
        await audioPlayer
            .setAudioSource(AudioSource.file(state.currentSong!.data));
        await audioPlayer.play();
      }
    });
  }
}
