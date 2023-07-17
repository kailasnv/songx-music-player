// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// request permission
Future<bool> requestStoragePermission(OnAudioQuery audioQuery) async {
  bool permissionStatus = await audioQuery.permissionsStatus();
  if (!permissionStatus) {
    await audioQuery.permissionsRequest(retryRequest: true);
    return permissionStatus;
  } else {
    debugPrint("storage permission enabled !");
    return permissionStatus;
  }
}
