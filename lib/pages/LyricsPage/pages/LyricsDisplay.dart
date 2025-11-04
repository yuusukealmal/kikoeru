// flutter
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// frb
import "package:kikoeru/src/rust/api/requests/interface.dart";

// 3rd lib
import "package:provider/provider.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

// pages
import "package:kikoeru/pages/LyricsPage/logic/LyricsHandler.dart";

class LyricsDisplay extends StatefulWidget {
  const LyricsDisplay({super.key});

  @override
  State<LyricsDisplay> createState() => _LyricsDisplayState();
}

class _LyricsDisplayState extends State<LyricsDisplay> {
  static const MethodChannel _channel = MethodChannel("PipNotify");
  List<dynamic> subtitles = [];

  @override
  void initState() {
    super.initState();
    _channel.setMethodCallHandler((call) async {
      if (call.method == "onExitPiP") {
        if (mounted) {
          final provider = Provider.of<AudioProvider>(context, listen: false);
          provider.isFromPiP = true;
          Navigator.of(context).pop();
        }
      }
    });
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
      future: textFetch(url: mediaUrl),
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

              return Center(
                child: Text(
                  currentText.isEmpty ? "" : currentText,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("字幕加载失败: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
