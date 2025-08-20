// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

// pages
import "package:provider/provider.dart";

// widgets
import "package:kikoeru/pages/AudioPlayerOverlay/widget/OpenFullPlayerButton.dart";
import "package:kikoeru/pages/AudioPlayerOverlay/widget/PreviewPlayerActionsButtom.dart";
import "package:kikoeru/pages/AudioPlayerOverlay/widget/PreviewPlayerText.dart";

class AudioPlayerOverlay extends StatefulWidget {
  const AudioPlayerOverlay({super.key});

  @override
  State<StatefulWidget> createState() => _AudioPlayerPewview();
}

class _AudioPlayerPewview extends State<AudioPlayerOverlay> {
  @override
  Widget build(BuildContext context) {
    final AudioProvider audioProvider = Provider.of<AudioProvider>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              openFullPlayerButton(context),
              Image.network(
                audioProvider.AudioInfo[AudioInfoType.SamCover]!,
                height: 60,
              ),
              AudioPlayerPreviewText(audioProvider),
              AudioPlayerPrevieActionButtom(audioProvider)
            ],
          ),
        ),
      ),
    );
  }
}
