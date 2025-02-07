import 'package:flutter/material.dart';

Widget getLeading(String type) {
  debugPrint(type);
  switch (type) {
    case "folder":
      return Icon(Icons.folder);
    case "audio":
      return Icon(Icons.music_note);
    case "image":
      return const Icon(Icons.image);
    case "text":
      return const Icon(Icons.insert_drive_file);
    default:
      return const Icon(Icons.insert_drive_file);
  }
}
