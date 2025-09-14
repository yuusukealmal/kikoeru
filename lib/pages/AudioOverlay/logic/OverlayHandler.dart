// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

// pages
import "package:kikoeru/pages/AudioOverlay/pages/AudioPlayerOverlay.dart";
import "package:kikoeru/pages/AudioOverlay/pages/LyricsOverlay.dart";

void setAudioPlayerOverlay(BuildContext context, AudioProvider audioProvider) {
  audioProvider.audioPlayerOverlayEntry =
      OverlayEntry(builder: (context) => AudioPlayerOverlay());
  Overlay.of(context).insert(audioProvider.audioPlayerOverlayEntry!);
}

void setLyricsOverlay(BuildContext context, AudioProvider audioProvider) {
  if (audioProvider.lyricsOverlayEntry != null) {
    return;
  }

  audioProvider.lyricsOverlayEntry =
      OverlayEntry(builder: (context) => LyricsOverlay());
  Overlay.of(context).insert(audioProvider.lyricsOverlayEntry!);
}

void refreshOverlay(
  BuildContext context,
  AudioProvider audioProvider,
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    hideOverlay(audioProvider, isClose: false);
    setAudioPlayerOverlay(context, audioProvider);

    if (audioProvider.AudioInfo[AudioInfoType.Lyrics] != null &&
        audioProvider.AudioInfo[AudioInfoType.Lyrics]!.isNotEmpty) {
      setLyricsOverlay(context, audioProvider);
    }
  });
}

void hideOverlay(AudioProvider audioProvider, {bool isClose = true}) {
  audioProvider.audioPlayerOverlayEntry?.remove();
  audioProvider.audioPlayerOverlayEntry = null;

  if (isClose == true) {
    audioProvider.lyricsOverlayEntry?.remove();
    audioProvider.lyricsOverlayEntry = null;
  }
}

void updateOverlay(AudioProvider audioProvider) {
  audioProvider.audioPlayerOverlayEntry?.markNeedsBuild();
  audioProvider.lyricsOverlayEntry?.markNeedsBuild();
}
