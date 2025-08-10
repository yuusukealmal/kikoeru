// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

StreamBuilder<Duration?> AudioPlayerProgressBar(AudioPlayer audioPlayer) {
  return StreamBuilder<Duration?>(
    stream: audioPlayer.positionStream,
    builder: (context, snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          total: audioPlayer.duration ?? Duration.zero,
          onSeek: (duration) {
            audioPlayer.seek(duration);
          },
        ),
      );
    },
  );
}
