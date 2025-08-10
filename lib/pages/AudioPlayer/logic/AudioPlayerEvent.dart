// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

void hidePlayer(BuildContext context, AudioProvider audioProvider) {
  Provider.of<AudioProvider>(context, listen: false).setIsAudioScreen(false);
  audioProvider.updateOverlay(context);
  Navigator.pop(context);
}

void onPreviewPress(BuildContext context, AudioProvider audioProvider) {
  debugPrint(audioProvider.index.toString());
  if (audioProvider.index! > 0) {
    audioProvider.stopAudio();
    int index = audioProvider.index! - 1;
    audioProvider.setIndex(index);
    audioProvider.seekToPrevious(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已經是第一首了")),
    );
  }
}

void onNextPress(BuildContext context, AudioProvider audioProvider) {
  debugPrint(audioProvider.index.toString());
  if (audioProvider.index! < audioProvider.length! - 1) {
    audioProvider.stopAudio();
    int index = audioProvider.index! + 1;
    audioProvider.setIndex(index);
    audioProvider.seekToNext(context);
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
