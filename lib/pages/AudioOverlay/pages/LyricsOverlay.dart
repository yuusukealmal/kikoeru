// flutter
import 'package:flutter/material.dart';

// frb
import "package:kikoeru/src/rust/api/requests/interface.dart";

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

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

  String? _cachedSubtitle;
  int? _cachedIndex;
  String? _cachedMediaUrl;

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    position = Offset(0, MediaQuery.of(context).size.height - 120);
  }

  Future<void> _loadSubtitles(String mediaUrl, int currentIndex) async {
    if (_cachedIndex == currentIndex &&
        _cachedMediaUrl == mediaUrl &&
        _cachedSubtitle != null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final requestedUrl = mediaUrl;
    final requestedIndex = currentIndex;

    try {
      final data = await textFetch(url: mediaUrl);
      if (!mounted) return;

      final provider = Provider.of<AudioProvider>(context, listen: false);
      final latestIndex =
          provider.AudioPlayerInfo[AudioPlayerInfoType.CurrentIndex];
      final lyricsInfo = provider.AudioInfo[AudioInfoType.Lyrics];
      final latestUrl = (lyricsInfo != null &&
              latestIndex >= 0 &&
              latestIndex < lyricsInfo.length)
          ? lyricsInfo[latestIndex].mediaStreamUrl
          : null;

      if (latestUrl != requestedUrl || latestIndex != requestedIndex) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _cachedSubtitle = data;
        _cachedIndex = requestedIndex;
        _cachedMediaUrl = requestedUrl;
        subtitles = getSubTitleClass(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudioProvider>(context);
    final currentIndex =
        provider.AudioPlayerInfo[AudioPlayerInfoType.CurrentIndex];

    final lyricsInfo = provider.AudioInfo[AudioInfoType.Lyrics];
    if (lyricsInfo == null ||
        lyricsInfo.isEmpty ||
        currentIndex >= lyricsInfo.length ||
        currentIndex < 0) {
      return const SizedBox.shrink();
    }
    final mediaUrl = lyricsInfo[currentIndex].mediaStreamUrl;

    if (_cachedIndex != currentIndex || _cachedMediaUrl != mediaUrl) {
      _loadSubtitles(mediaUrl, currentIndex);
    }

    if (_isLoading) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<Duration>(
      stream: provider.AudioPlayerInfo[AudioPlayerInfoType.PositionStream],
      builder: (context, positionSnapshot) {
        final currentPosition = positionSnapshot.data ?? Duration.zero;
        final currentText = getCurrentSubtitle(currentPosition, subtitles);

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
                    decoration: TextDecoration.none,
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
  }
}
