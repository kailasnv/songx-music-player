import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:songx/data/hive%20class/database.dart';
import 'package:songx/domain/repo/fetchsongs_repo.dart';
import 'package:just_audio/just_audio.dart';

import '../../../utils/snackbar.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc()
      : super(SongsInitial(
            isLoading: false, isPlaying: false, favoritePlaylist: [])) {
    // GET ALL SONGS from device storage
    on<FetchAllSongsEvent>((event, emit) async {
      emit(SongsState(
        isLoading: true,
        isPlaying: false,
        favoritePlaylist: state.favoritePlaylist,
      ));

      final songs = await Repositary.getAllSongsFromDevice(event.audioQuery);

      emit(SongsState(
        isLoading: false,
        allTracksPlaylist: songs, //update the main list of songs
        isPlaying: false,
        favoritePlaylist: state.favoritePlaylist,
      ));
    });

    // GET  CURRENT TAPPED SONG and PLAY THE SONG - ( also can pause the song )
    on<GetCurrentSongEvent>((event, emit) async {
      var audioPlayer = event.audioPlayer;

      if (!audioPlayer.playing) {
        // if NOT playing , iam going to play it.
        emit(SongsState(
          isLoading: false,
          currentSong: event.currentSong, // updating current song
          allTracksPlaylist: state.allTracksPlaylist,
          isPlaying: true, // before play method , updating this to true
          songIndex: event.songIndex,
          favoritePlaylist: state.favoritePlaylist,
        ));
        // sets file to audioplayer  , then play the song..
        await audioPlayer
            .setAudioSource(AudioSource.file(event.currentSong.data));
        await audioPlayer.play();
      }

      // if already playing .. ... ... ... ,
      if (audioPlayer.playing) {
        // there is 2 scenarios-
        // checking if the user tapped the same song /or a new song
        if (event.currentSong == state.currentSong) {
          // if user tapped same song - then PAUSE the song

          emit(SongsState(
            isLoading: false,
            currentSong: event.currentSong,
            allTracksPlaylist: state.allTracksPlaylist,
            isPlaying: false,
            songIndex: state.songIndex,
            favoritePlaylist: state.favoritePlaylist,
          ));
          await audioPlayer.pause(); // pause the song
        } else {
          // if user tapped a NEW song then play the new song
          emit(SongsState(
            isLoading: false,
            currentSong: event.currentSong, // updating current song
            allTracksPlaylist: state.allTracksPlaylist,
            isPlaying: true,
            songIndex: event.songIndex,
            favoritePlaylist: state.favoritePlaylist,
          ));
          // set up a NEW audio file and  PLAY the new song
          await audioPlayer
              .setAudioSource(AudioSource.file(event.currentSong.data));
          await audioPlayer.play();
        }
      }
    });

    // play and pause events
    on<PlayPauseSong>((event, emit) async {
      var audioPlayer = event.audioPlayer;

      if (audioPlayer.playing) {
        // before pause or play, I need to update the isPlaying state
        emit(SongsState(
          isLoading: false,
          isPlaying: false, // set to pause
          currentSong: state.currentSong,
          allTracksPlaylist: state.allTracksPlaylist,
          songIndex: state.songIndex,
          favoritePlaylist: state.favoritePlaylist,
        ));
        await audioPlayer.pause(); // then pause song
      } else {
        emit(SongsState(
          isLoading: false,
          isPlaying: true, // set to play
          currentSong: state.currentSong,
          allTracksPlaylist: state.allTracksPlaylist,
          songIndex: state.songIndex,
          favoritePlaylist: state.favoritePlaylist,
        ));
        await audioPlayer.play(); // then play song
      }
    });

    // skip to NEXT song event
    on<PlayNextSong>((event, emit) async {
      final audioPlayer = event.audioPlayer;
      if (state.songIndex != null) {
        emit(SongsState(
          isLoading: false,
          isPlaying: state.isPlaying,
          allTracksPlaylist: state.allTracksPlaylist,
          currentSong: state.allTracksPlaylist![
              state.songIndex! + 1], // updating current song by +1
          songIndex: state.songIndex! + 1, //also updating song index by + 1
          favoritePlaylist: state.favoritePlaylist,
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
          allTracksPlaylist: state.allTracksPlaylist,
          currentSong: state.allTracksPlaylist![state.songIndex! - 1],
          songIndex: state.songIndex! - 1,
          favoritePlaylist: state.favoritePlaylist,
        ));

        // set up a PREVIOUS audio file and  PLAY the previous song
        await audioPlayer
            .setAudioSource(AudioSource.file(state.currentSong!.data));
        await audioPlayer.play();
      }
    });

    // Manage Fav songs event
    on<AddToFavEvent>((event, emit) async {
      // object of databse class
      Database db = Database();

      var song = event.currentSong;

      print("adding  ${song.title}  to fav playlist");

      // if this song already containes , then REMOVE it from FAV list
      if (state.favoritePlaylist.contains(song)) {
        state.favoritePlaylist.remove(song); // remove song
        // then update state
        emit(SongsState(
          isLoading: false,
          isPlaying: state.isPlaying,
          allTracksPlaylist: state.allTracksPlaylist,
          songIndex: state.songIndex,
          currentSong: state.currentSong,
          favoritePlaylist: state.favoritePlaylist, // update state
        ));

        // snackbar to give a feedback to user
        showSomeFeedback(event.context, "Song removed from favorite.");

        // remove & update hive
        db.updateDatabase(state);
      } else {
        // if this song is not in Fav
        // ADD song to Favorite Playlist
        state.favoritePlaylist.add(song);
        // then update state
        emit(SongsState(
          isLoading: false,
          isPlaying: state.isPlaying,
          allTracksPlaylist: state.allTracksPlaylist,
          songIndex: state.songIndex,
          currentSong: state.currentSong,
          favoritePlaylist: state.favoritePlaylist, // update state
        ));

        // snackbar
        showSomeFeedback(event.context, "Song added to favorite.");

        // add & update hive db
        db.updateDatabase(state);
      }
    });

    // when app starts,  GET all FAV songs IDs from hive db
    on<FetchFavoritePlaylistEvent>((event, emit) async {
      // instance of hive db class
      Database db = Database();
      db.loadDataFromHive();

      print("favSongsIDs = ${db.favIDs.toString()}");

      // this will give me some time to Fill up data in  allTracksPlaylist..
      await Future.delayed(const Duration(seconds: 2));

      // checking fav songs...
      if (state.allTracksPlaylist != null) {
        for (var i = 0; i < state.allTracksPlaylist!.length; i++) {
          for (var j = 0; j < state.allTracksPlaylist!.length; j++) {
            // if ids are same. add that song to favoritePlaylist

            if (db.favIDs[i] == state.allTracksPlaylist![j].id) {
              state.favoritePlaylist.add(state.allTracksPlaylist![j]);
            }
          }
        }
        // update state
        emit(SongsState(
          isLoading: state.isLoading,
          favoritePlaylist: state.favoritePlaylist, // updates the state of FAV
          isPlaying: state.isPlaying,
          allTracksPlaylist: state.allTracksPlaylist,
          currentSong: state.currentSong,
          songIndex: state.songIndex,
        ));
      }
    });
  }
}
