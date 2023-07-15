import 'package:hive_flutter/hive_flutter.dart';
import 'package:songx/presentation/state_managment/songs_bloc/songs_bloc.dart';

class Database {
  // temporary variable to store data , and to upload to hive
  List<int> favIDs = [];

  // open hive db ref
  final myBox = Hive.box("favorite");

  // this will give all data from HIVE
  loadDataFromHive() {
    if (myBox.get("FAV_KEY") != null) {
      favIDs = myBox.get("FAV_KEY");
    }
  }

  // add or remove from database
  updateDatabase(SongsState state) async {
    for (var i = 0; i < state.favoritePlaylist.length; i++) {
      favIDs.add(state.favoritePlaylist[i].id);
    }
    await myBox.put("FAV_KEY", favIDs);
  }
}
