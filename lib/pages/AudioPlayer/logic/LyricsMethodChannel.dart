// flutter
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// pages
import "package:kikoeru/pages/LyricsPage/pages/LyricsDisplay.dart";

void EnterPip(BuildContext context) async {
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
