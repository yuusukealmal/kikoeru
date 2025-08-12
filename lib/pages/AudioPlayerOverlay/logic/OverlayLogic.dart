// flutter
import 'package:flutter/material.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// pages
import 'package:kikoeru/pages/AudioPlayerOverlay/pages/AudioPlayerOverlay.dart';

OverlayEntry createOverlayEntry(BuildContext context) {
  return OverlayEntry(builder: (context) => AudioPlayerOverlay());
}

void refreshOverlay(
  BuildContext context,
  AudioProvider audioProvider,
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    hideOverlay(audioProvider);
    audioProvider.overlayEntry = createOverlayEntry(context);
    Overlay.of(context).insert(audioProvider.overlayEntry!);
  });
}

void hideOverlay(AudioProvider audioProvider) {
  audioProvider.overlayEntry?.remove();
  audioProvider.overlayEntry = null;
}

void updateOverlay(AudioProvider audioProvider) {
  audioProvider.overlayEntry?.markNeedsBuild();
}
