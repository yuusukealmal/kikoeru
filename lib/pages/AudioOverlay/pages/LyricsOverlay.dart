// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// utils
import 'package:kikoeru/core/utils/httpBase.dart';

// logic
import 'package:kikoeru/pages/LyricsPage/logic/LyricsHandler.dart';

class LyricsOverlay extends StatefulWidget {
  const LyricsOverlay({super.key});

  @override
  State<LyricsOverlay> createState() => _LyricsOverlayState();
}

class _LyricsOverlayState extends State<LyricsOverlay> {
  late Offset position;
  List<dynamic> subtitles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    position = Offset(0, MediaQuery.of(context).size.height - 120);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudioProvider>(context);
    final currentIndex =
        provider.AudioPlayerInfo[AudioPlayerInfoType.CurrentIndex];
    final mediaUrl =
        provider.AudioInfo[AudioInfoType.Lyrics][currentIndex].mediaStreamUrl;

    return FutureBuilder<String>(
      key: ValueKey(currentIndex),
      future: HttpBase.get(Uri.parse(mediaUrl)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          subtitles = getSubTitleClass(snapshot.data!);

          return StreamBuilder<Duration>(
            stream:
                provider.AudioPlayerInfo[AudioPlayerInfoType.PositionStream],
            builder: (context, positionSnapshot) {
              final currentPosition = positionSnapshot.data ?? Duration.zero;
              final currentText =
                  getCurrentSubtitle(currentPosition, subtitles);

              return Positioned(
                left: position.dx,
                top: position.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      position += details.delta;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(180, 146, 146, 146),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        currentText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          Navigator.pop(context);
          return const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
