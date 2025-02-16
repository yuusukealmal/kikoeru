import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:kikoeru/widget/AudioPlayerWidget.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioUrl;
  String? _currentAudioTitle;
  String? _currentAudioWorkTitle;
  String? _samCoverUrl;
  String? _mainCoverUrl;
  bool _isPlaying = false;
  bool _isOverlayShow = false;
  OverlayEntry? _overlayEntry;

  AudioPlayer get audioPlayer => _audioPlayer;
  bool get isPlaying => _isPlaying;
  bool get isOverlayShow => _isOverlayShow;
  String? get currentAudioTitle => _currentAudioTitle;
  String? get currentAudioWorkTitle => _currentAudioWorkTitle;
  String? get samCoverUrl => _samCoverUrl;
  String? get mainCoverUrl => _mainCoverUrl;
  Stream<bool> get playingStream => _audioPlayer.playingStream;

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
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
                  Stack(
                    children: [
                      Image.network(
                        _samCoverUrl ?? "",
                        height: 60,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.queue,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // _overlayEntry?.remove();
                            // _overlayEntry = null;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioPlayerScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ListTile(
                      title: SizedBox(
                        height: 20,
                        child: Marquee(
                          text: _currentAudioTitle ?? "正在播放",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      subtitle: SizedBox(
                        height: 20,
                        child: Marquee(
                          text: _currentAudioWorkTitle ?? "正在播放",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      if (_isPlaying) {
                        pauseAudio();
                      } else {
                        resumeAudio();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: stopAudio,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> playAudio(BuildContext context, Map<String, dynamic> dict,
      String samCoverUrl, String mainCoverUrl) async {
    String url = dict["mediaStreamUrl"];

    if (_currentAudioUrl != url) {
      _audioPlayer.stop();
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      _currentAudioUrl = url;
      _currentAudioTitle = dict["title"];
      _currentAudioWorkTitle = dict["workTitle"];
      _samCoverUrl = samCoverUrl;
      _mainCoverUrl = mainCoverUrl;
      _isPlaying = true;
      updateOverlay(context);
    } else {
      if (_isPlaying) {
        _audioPlayer.pause();
        _isPlaying = false;
      } else {
        _audioPlayer.play();
        _isPlaying = true;
      }
    }
    notifyListeners();
  }

  Future<void> pauseAudio() async {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
    _updateOverlayIfNeeded();
  }

  Future<void> resumeAudio() async {
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
    _updateOverlayIfNeeded();
  }

  Future<void> stopAudio() async {
    _audioPlayer.stop();
    _isPlaying = false;
    _currentAudioUrl = null;
    _currentAudioTitle = null;
    _currentAudioWorkTitle = null;
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isOverlayShow = false;
    }
    notifyListeners();
  }

  void updateOverlay(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
        _isOverlayShow = false;
      }

      _overlayEntry = _createOverlayEntry(context);
      _isOverlayShow = true;
      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void _updateOverlayIfNeeded() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }
}
