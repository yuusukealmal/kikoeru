// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// func
import 'package:kikoeru/pages/AudioPlayer/logic/AudioPlayerEvent.dart';
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayLogic.dart';
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayRouteObserver.dart';

// widgets
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerHeader.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerImage.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerProgressBar.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerText.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerController.dart';
import 'package:kikoeru/pages/AudioPlayer/widgets/AudioPlayerVolumeController.dart';

// pages
import 'package:kikoeru/main.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with OverlayRouteAware {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    hideOverlay(audioProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          updateOverlay(audioProvider);
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
                top: MediaQuery.of(context).size.height / 2 - 350,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AudioPlayerImage(audioProvider),
                    SizedBox(height: 30),
                    AudioPlayerText(audioProvider),
                    SizedBox(height: 65),
                    AudioPlayerProgressBar(audioProvider),
                    SizedBox(height: 10),
                    AudioPlayerController(audioProvider: audioProvider),
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
