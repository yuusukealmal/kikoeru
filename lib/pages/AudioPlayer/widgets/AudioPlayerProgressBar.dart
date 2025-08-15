// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

StreamBuilder<Duration?> AudioPlayerProgressBar(AudioProvider audioProvider) {
  return StreamBuilder<Duration?>(
    stream: audioProvider.AudioPlayerInfo[AudioPlayerInfoType.Position],
    builder: (context, snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          total: audioProvider.AudioPlayerInfo[AudioPlayerInfoType.Duration] ??
              Duration.zero,
          onSeek: (duration) {
            audioProvider.seek(duration);
          },
        ),
      );
    },
  );
}
