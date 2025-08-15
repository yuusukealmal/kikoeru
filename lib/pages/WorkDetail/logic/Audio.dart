// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

mixin WorkAudio {
  List<Map<String, dynamic>> getAudioList(List<dynamic>? children) {
    return children
            ?.where((child) => child["type"] == "audio")
            .map((child) => child as Map<String, dynamic>)
            .toList() ??
        [];
  }

  void playAudio(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> dict,
    int index,
    String mainCoverUrl,
    String samCoverUrl,
  ) {
    Provider.of<AudioProvider>(context, listen: false).playAudioList(
      context,
      title: title,
      index: index,
      rawAudioSource: dict,
      mainCoverUrl: mainCoverUrl,
      samCoverUrl: samCoverUrl,
    );
  }

  void stopAudio(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).stopAudio();
  }

  void toggleAudio(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).togglePlayPause();
  }
}
