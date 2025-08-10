// flutter
import 'package:flutter/material.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

Widget AudioPlayerText(AudioProvider audioProvider) {
  return Column(
    children: [
      Text(
        audioProvider.currentAudioTitle ?? "",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 30),
      Text(
        audioProvider.currentAudioWorkTitle ?? "",
        style: TextStyle(fontSize: 14),
      ),
    ],
  );
}
