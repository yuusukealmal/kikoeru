// flutter
import 'package:flutter/material.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// function
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayLogic.dart';

void hidePlayer(BuildContext context, AudioProvider audioProvider) {
  refreshOverlay(context, audioProvider);
  Navigator.pop(context);
}

void onPreviewPress(BuildContext context, AudioProvider audioProvider) {
  if (audioProvider.hasPrevious) {
    audioProvider.previousTrack();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已經是第一首了")),
    );
  }
}

void onNextPress(BuildContext context, AudioProvider audioProvider) {
  if (audioProvider.hasNext) {
    audioProvider.nextTrack();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已經是最後一首了")),
    );
  }
}

void audioPlayerSeek(AudioProvider audioProvider, int seconds) {
  audioProvider.seek(Duration(seconds: seconds));
}
