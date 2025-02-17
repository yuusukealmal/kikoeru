import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:kikoeru/config/AudioProvider.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AudioProvider>(context, listen: false).setIsAudioScreem(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final _audioPlayer = audioProvider.audioPlayer;

    audioProvider.hideOverlay();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Provider.of<AudioProvider>(context, listen: false)
              .setIsAudioScreem(false);
          audioProvider.updateOverlay(context);
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 5) {
              Provider.of<AudioProvider>(context, listen: false)
                  .setIsAudioScreem(false);
              audioProvider.updateOverlay(context);
              Navigator.pop(context);
            }
          },
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  height: 20,
                  color: Colors.grey[300],
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 300,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          audioProvider.mainCoverUrl ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      audioProvider.currentAudioTitle ?? 'Online Music Stream',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      audioProvider.currentAudioWorkTitle ??
                          'Streaming MP3/WAV from URL',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 65),
                    // Progress Bar
                    StreamBuilder<Duration?>(
                      stream: _audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          child: ProgressBar(
                            progress: snapshot.data ?? Duration.zero,
                            total: _audioPlayer.duration ?? Duration.zero,
                            onSeek: (duration) {
                              _audioPlayer.seek(duration);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.skip_previous,
                            size: 32,
                          ),
                          onPressed: () {
                            if (audioProvider.index! > 0) {
                              audioProvider.stopAudio();
                              int index = audioProvider.index! - 1;
                              audioProvider.setIndex(index);
                              audioProvider.playAudio(
                                  context,
                                  audioProvider
                                      .audioList![audioProvider.index!]);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.replay_5,
                            size: 32,
                          ),
                          onPressed: () {
                            _audioPlayer.seek(
                                _audioPlayer.position - Duration(seconds: 5));
                          },
                        ),
                        StreamBuilder<bool>(
                          stream: audioProvider.playingStream,
                          builder: (context, snapshot) {
                            final isPlaying = snapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                size: 48,
                              ),
                              onPressed: () {
                                isPlaying
                                    ? audioProvider.pauseAudio()
                                    : audioProvider.resumeAudio();
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.forward_5,
                            size: 32,
                          ),
                          onPressed: () {
                            _audioPlayer.seek(
                              _audioPlayer.position + Duration(seconds: 5),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            size: 32,
                          ),
                          onPressed: () {
                            if (audioProvider.index! <
                                audioProvider.audioList!.length - 1) {
                              audioProvider.stopAudio();
                              int index = audioProvider.index! + 1;
                              audioProvider.setIndex(index);
                              audioProvider.playAudio(
                                  context,
                                  audioProvider
                                      .audioList![audioProvider.index!]);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
