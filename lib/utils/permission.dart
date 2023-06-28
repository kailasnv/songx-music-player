import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

void requestStoragePermission(OnAudioQuery audioQuery) async {
  bool permissionStatus = await audioQuery.permissionsStatus();
  if (!permissionStatus) {
    await audioQuery.permissionsRequest();
  } else {
    debugPrint("storage permission enabled !");
  }
  // setState(() {});
}
