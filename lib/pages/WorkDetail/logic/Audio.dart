// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:provider/provider.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

// class
import "package:kikoeru/class/TrackInfo/models/TrackInfoMediaClass.dart";

mixin WorkAudio {
  (List<TypeAudioClass>, List<TypeMediaClass>) getAudioList(
      List<dynamic>? children) {
    return (
      children
              ?.where((child) => child.type == "audio")
              .cast<TypeAudioClass>()
              .toList() ??
          [],
      children
              ?.where((child) =>
                  (child.title.endsWith(".vtt") ||
                      child.title.endsWith(".lrc")) &&
                  child.type == "text")
              .cast<TypeMediaClass>()
              .toList() ??
          []
    );
  }

  void playAudio(
    BuildContext context,
    String title,
    List<TypeAudioClass> dict,
    int index,
    String mainCoverUrl,
    String samCoverUrl,
    List<TypeMediaClass> subtitle,
  ) {
    Provider.of<AudioProvider>(context, listen: false).playAudioList(
      context,
      title: title,
      index: index,
      rawAudioSource: dict,
      mainCoverUrl: mainCoverUrl,
      samCoverUrl: samCoverUrl,
      subtitle: subtitle,
    );
  }

  void stopAudio(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).stopAudio();
  }

  void toggleAudio(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).togglePlayPause();
  }
}
