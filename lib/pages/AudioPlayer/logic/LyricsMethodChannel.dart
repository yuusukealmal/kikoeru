// flutter
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

// pages
import "package:kikoeru/pages/LyricsPage/pages/LyricsDisplay.dart";
import "package:kikoeru/pages/AudioOverlay/logic/OverlayHandler.dart";

void EnterPip(BuildContext context, AudioProvider audioProvider) async {
  hideOverlay(audioProvider, isClose: true);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LyricsDisplay(),
    ),
  );
  const _channel = MethodChannel("PipNotify");

  try {
    await _channel.invokeMethod("enterPiP");
  } catch (e) {
    debugPrint("Error calling PiP: $e");
  }
}
