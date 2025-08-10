// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// func
import 'package:kikoeru/pages/AudioPlayer/logic/AudioPlayerEvent.dart';

// widgets
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerHeader.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerImage.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerProgressBar.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerText.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerController.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerVolumeController.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<AudioProvider>(context, listen: false).setIsAudioScreen(true);
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
              .setIsAudioScreen(false);
          audioProvider.updateOverlay(context);
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 5) hidePlayer(context, audioProvider);
          },
          child: Stack(
            children: [
              Header(),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 300,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AudioPlayerImage(audioProvider),
                    SizedBox(height: 30),
                    AudioPlayerText(audioProvider),
                    SizedBox(height: 65),
                    AudioPlayerProgressBar(_audioPlayer),
                    SizedBox(height: 10),
                    AudioPlayerController(
                      audioProvider: audioProvider,
                      audioPlayer: _audioPlayer,
                    ),
                    SizedBox(height: 25),
                    AudioPlayerVolumeController()
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
