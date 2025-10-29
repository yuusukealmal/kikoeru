// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

Widget AudioPlayerText(AudioProvider audioProvider) {
  return Padding(
    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
    child: Column(
      children: [
        Text(
          audioProvider.AudioInfo[AudioInfoType.MainTitle]!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Text(
          audioProvider.AudioInfo[AudioInfoType.SubTitle]!,
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}
