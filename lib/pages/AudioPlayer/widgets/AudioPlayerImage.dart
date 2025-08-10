// flutter
import 'package:flutter/material.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

Widget AudioPlayerImage(AudioProvider audioProvider) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
      audioProvider.mainCoverUrl ?? "",
      fit: BoxFit.cover,
    ),
  );
}
