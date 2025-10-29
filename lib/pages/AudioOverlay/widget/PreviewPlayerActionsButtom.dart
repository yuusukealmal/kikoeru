// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

Widget AudioPlayerPrevieActionButtom(AudioProvider audioProvider) {
  return Row(
    children: [
      IconButton(
        icon: Icon(
          audioProvider.AudioPlayerInfo[AudioPlayerInfoType.IsPlaying]
              ? Icons.pause
              : Icons.play_arrow,
        ),
        onPressed: audioProvider.togglePlayPause,
      ),
      IconButton(icon: Icon(Icons.close), onPressed: audioProvider.stopAudio),
    ],
  );
}
