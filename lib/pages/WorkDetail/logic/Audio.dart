// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// class
import 'package:kikoeru/class/TrackInfo/models/TrackInfoMediaClass.dart';

mixin WorkAudio {
  List<TypeAudioClass> getAudioList(List<dynamic>? children) {
    return children
            ?.where((child) => child.type == "audio")
            .cast<TypeAudioClass>()
            .toList() ??
        [];
  }

  void playAudio(
    BuildContext context,
    String title,
    List<TypeAudioClass> dict,
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
