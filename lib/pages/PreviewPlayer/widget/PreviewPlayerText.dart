// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:marquee/marquee.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

Widget AudioPlayerPreviewText(AudioProvider audioProvider) {
  return Expanded(
    child: ListTile(
      title: SizedBox(
        height: 20,
        child: Marquee(
          text: audioProvider.currentAudioWorkTitle ?? "正在播放",
          style: TextStyle(fontSize: 16),
        ),
      ),
      subtitle: SizedBox(
        height: 20,
        child: Marquee(
          text: audioProvider.currentAudioWorkTitle ?? "正在播放",
          style: TextStyle(fontSize: 12),
        ),
      ),
    ),
  );
}
