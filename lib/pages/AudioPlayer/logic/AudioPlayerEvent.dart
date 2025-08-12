// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:just_audio/just_audio.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// function
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayLogic.dart';

void hidePlayer(BuildContext context, AudioProvider audioProvider) {
  refreshOverlay(context, audioProvider);
  Navigator.pop(context);
}

void onPreviewPress(BuildContext context, AudioProvider audioProvider) {
  debugPrint(audioProvider.currentTrackIndex.toString());
  if (audioProvider.currentTrackIndex! > 0) {
    audioProvider.stopAudio();
    int index = audioProvider.currentTrackIndex! - 1;
    audioProvider.setTrack(index);
    audioProvider.seekToPrevious();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已經是第一首了")),
    );
  }
}

void onNextPress(BuildContext context, AudioProvider audioProvider) {
  debugPrint(audioProvider.currentTrackIndex.toString());
  if (audioProvider.currentTrackIndex! <
      audioProvider.AudioInfo[AudioInfoType.TotalTrackLength] - 1) {
    audioProvider.stopAudio();
    int index = audioProvider.currentTrackIndex! + 1;
    audioProvider.setTrack(index);
    audioProvider.seekToNext();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已經是最後一首了")),
    );
  }
}

void audioPlayerSeek(AudioPlayer audioPlayer, int seconds) {
  if (seconds > 0) {
    audioPlayer.seek(audioPlayer.position + Duration(seconds: 5));
  } else {
    audioPlayer.seek(audioPlayer.position - Duration(seconds: 5));
  }
}
