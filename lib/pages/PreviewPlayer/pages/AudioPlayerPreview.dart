// flutter
import 'package:flutter/material.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// pages
import 'package:provider/provider.dart';

// widgets
import 'package:kikoeru/pages/PreviewPlayer/widget/OpenFullPlayerButton.dart';
import 'package:kikoeru/pages/PreviewPlayer/widget/PreviewPlayerActionsButtom.dart';
import 'package:kikoeru/pages/PreviewPlayer/widget/PreviewPlayerText.dart';

class AudioPlayerPewview extends StatefulWidget {
  const AudioPlayerPewview({super.key});

  @override
  State<StatefulWidget> createState() => _AudioPlayerPewview();
}

class _AudioPlayerPewview extends State<AudioPlayerPewview> {
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
              SizedBox(width: 8),
              Image.network(audioProvider.sameCoverUrl ?? "", height: 80),
              SizedBox(width: 8),
              AudioPlayerPreviewText(audioProvider),
              AudioPlayerPrevieActionButtom(audioProvider)
            ],
          ),
        ),
      ),
    );
  }
}
