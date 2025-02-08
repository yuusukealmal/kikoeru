import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioUrl;
  String? _currentAudioTitle;
  String? _currentAudioWorkTitle;
  String? _samCoverUrl;
  bool _isPlaying = false;
  OverlayEntry? _overlayEntry;

  bool get isPlaying => _isPlaying;
  String? get currentAudioTitle => _currentAudioTitle;
  String? get currentAudioWorkTitle => _currentAudioWorkTitle;

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
                  Image.network(
                    _samCoverUrl ?? "",
                    height: 60,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        _currentAudioTitle ?? "正在播放",
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        _currentAudioWorkTitle ?? "正在播放",
                        style: TextStyle(fontSize: 12),
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

  Future<void> playAudio(
      BuildContext context, Map<String, dynamic> dict, String ImageUrl) async {
    String url = dict["mediaStreamUrl"];

    if (_currentAudioUrl != url) {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      _currentAudioUrl = url;
      _currentAudioTitle = dict["title"];
      _currentAudioWorkTitle = dict["workTitle"];
      _samCoverUrl = ImageUrl;
      _isPlaying = true;
      _updateOverlay(context);
    } else {
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
      } else {
        await _audioPlayer.resume();
        _isPlaying = true;
      }
    }
    notifyListeners();
  }

  void _updateOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
    _updateOverlayIfNeeded();
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
    _updateOverlayIfNeeded();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentAudioUrl = null;
    _currentAudioTitle = null;
    _currentAudioWorkTitle = null;
    notifyListeners();
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _updateOverlayIfNeeded() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }
}
