import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:kikoeru/widget/AudioPlayerWidget.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioUrl, _currentAudioTitle, _currentAudioWorkTitle;
  String? _samCoverUrl, _mainCoverUrl;
  bool _isPlaying = false, _isOverlayShow = false, _isAudioScreen = false;
  OverlayEntry? _overlayEntry;
  int? _index;
  List<Map<String, dynamic>>? _audioList;

  AudioPlayer get audioPlayer => _audioPlayer;
  bool get isOverlayShow => _isOverlayShow;
  String? get currentAudioTitle => _currentAudioTitle;
  String? get currentAudioWorkTitle => _currentAudioWorkTitle;
  String? get mainCoverUrl => _mainCoverUrl;
  Stream<bool> get playingStream => _audioPlayer.playingStream;
  int? get index => _index;
  List<Map<String, dynamic>>? get audioList => _audioList;

  void setIndex(int index) => _index = index;
  void setIsAudioScreen(bool value) => _isAudioScreen = value;

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
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
                    Image.network(_samCoverUrl ?? "", height: 60),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: Icon(Icons.queue, color: Colors.white),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPlayerScreen(),
                          ),
                        ),
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
                  onPressed: togglePlayPause,
                ),
                IconButton(icon: Icon(Icons.close), onPressed: stopAudio),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> playAudio(
    BuildContext context,
    Map<String, dynamic> dict,
  ) async {
    String url = dict["mediaStreamUrl"];

    if (_currentAudioUrl != url) {
      await stopAudio();
      _currentAudioUrl = url;
      _currentAudioTitle = dict["title"];
      _currentAudioWorkTitle = dict["workTitle"];
      await _audioPlayer.setUrl(url);
      _isPlaying = true;
      _audioPlayer.play();
      updateOverlay(context);
    } else {
      // togglePlayPause();
    }
    notifyListeners();
  }

  void playAudioList(
    BuildContext context,
    int index,
    List<Map<String, dynamic>> audioList,
    String mainCoverUrl,
    String samCoverUrl,
  ) {
    _index = index;
    _audioList = audioList;
    _mainCoverUrl = mainCoverUrl;
    _samCoverUrl = samCoverUrl;
    playAudio(context, audioList[index]);
  }

  void togglePlayPause() {
    _isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
    _isPlaying = !_isPlaying;
    notifyListeners();
    _updateOverlayIfNeeded();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentAudioUrl = _currentAudioTitle = _currentAudioWorkTitle = null;
    hideOverlay();
    notifyListeners();
  }

  void updateOverlay(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hideOverlay();
      if (!_isAudioScreen) {
        _overlayEntry = _createOverlayEntry(context);
        Overlay.of(context).insert(_overlayEntry!);
        _isOverlayShow = true;
      }
    });
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOverlayShow = false;
  }

  void _updateOverlayIfNeeded() {
    _overlayEntry?.markNeedsBuild();
  }
}
