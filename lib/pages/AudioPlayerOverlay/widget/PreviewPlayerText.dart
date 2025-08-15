// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:marquee/marquee.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

Widget AudioPlayerPreviewText(AudioProvider audioProvider) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Marquee(
              text: audioProvider.AudioInfo[AudioInfoType.MainTitle]!,
              style: TextStyle(fontSize: 16),
              blankSpace: 12,
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            height: 20,
            child: Marquee(
              text: audioProvider.AudioInfo[AudioInfoType.SubTitle]!,
              style: TextStyle(fontSize: 12),
              blankSpace: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
