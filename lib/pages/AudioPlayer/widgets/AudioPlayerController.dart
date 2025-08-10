// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:just_audio/just_audio.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';
import 'package:kikoeru/pages/AudioPlayer/logic/AudioPlayerEvent.dart';

class AudioPlayerController extends StatefulWidget {
  final AudioProvider audioProvider;
  final AudioPlayer audioPlayer;

  const AudioPlayerController({
    super.key,
    required this.audioProvider,
    required this.audioPlayer,
  });

  @override
  State<StatefulWidget> createState() => _AudioPlayerControllerState();
}

class _AudioPlayerControllerState extends State<AudioPlayerController> {
  AudioProvider get audioProvider => widget.audioProvider;
  AudioPlayer get audioPlayer => widget.audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.skip_previous,
            size: 32,
          ),
          onPressed: () => onPreviewPress(context, audioProvider),
        ),
        IconButton(
          icon: Icon(
            Icons.replay_5,
            size: 32,
          ),
          onPressed: () => audioPlayerSeek(audioPlayer, -5),
        ),
        StreamBuilder<bool>(
          stream: audioProvider.playingStream,
          builder: (context, snapshot) {
            final isPlaying = snapshot.data ?? false;
            return IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 48,
              ),
              onPressed: () {
                audioProvider.togglePlayPause();
              },
            );
          },
        ),
        IconButton(
            icon: Icon(
              Icons.forward_5,
              size: 32,
            ),
            onPressed: () => audioPlayerSeek(audioPlayer, 5)),
        IconButton(
            icon: Icon(
              Icons.skip_next,
              size: 32,
            ),
            onPressed: () => onNextPress(context, audioProvider)),
      ],
    );
  }
}
