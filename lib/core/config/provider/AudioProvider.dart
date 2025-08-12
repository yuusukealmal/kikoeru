// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:just_audio/just_audio.dart';

// function
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayLogic.dart';

enum AudioInfoType {
  CurrentTrackIndex,
  TotalTrackLength,
  IsPlaying,
  MainTitle,
  SubTitle,
  MainCover,
  SamCover
}

class AudioProvider extends ChangeNotifier {
  AudioProvider() {
    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _trackIndex = index;
        setAudio(
          _audioList?[index]["mediaStreamUrl"],
          _audioList?[index]["title"],
          _audioList?[index]["workTitle"],
        );
        updateOverlay(this);
        notifyListeners();
      }
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  OverlayEntry? overlayEntry;

  String? _currentAudioUrl;
  String? _currentAudioTitle;
  String? _currentAudioSubTitle;
  String? _samCoverUrl;
  String? _mainCoverUrl;
  bool _isPlaying = false;
  int _trackIndex = 0;
  int _trackLength = 0;
  ConcatenatingAudioSource? playList;
  List<Map<String, dynamic>>? _audioList;

  void setAudio(String url, String title, String subtitle) {
    _currentAudioUrl = url;
    _currentAudioTitle = title;
    _currentAudioSubTitle = subtitle;
  }

  void resetAudio() {
    _currentAudioUrl = null;
    _currentAudioTitle = null;
    _currentAudioSubTitle = null;
  }

  Future<void> previousTrack() async {
    _trackIndex--;
    await playAudio(_trackIndex);
    updateOverlay(this);
  }

  Future<void> nextTrack() async {
    _trackIndex++;
    await playAudio(_trackIndex);
    updateOverlay(this);
  }

  Future<void> playAudio(
    int index,
  ) async {
    String url = _audioList![index]["mediaStreamUrl"];
    if (_currentAudioUrl != url) {
      await stopAudio();
      setAudio(
        url,
        _audioList?[index]["title"],
        _audioList?[index]["workTitle"],
      );

      await _audioPlayer.setAudioSource(
        playList!,
        initialIndex: _trackIndex,
        initialPosition: Duration.zero,
      );
      _isPlaying = true;
      _audioPlayer.play();
      updateOverlay(this);
    } else {
      // togglePlayPause();
    }
    notifyListeners();
  }

  void playAudioList(
    BuildContext context,
    int index,
    List<Map<String, dynamic>> rawAudioSource, [
    String? mainCoverUrl,
    String? samCoverUrl,
  ]) {
    _trackIndex = index;
    _mainCoverUrl = mainCoverUrl;
    _samCoverUrl = samCoverUrl;
    List<UriAudioSource> audioList = rawAudioSource
        .map(
          (item) => AudioSource.uri(
            Uri.parse(item["mediaStreamUrl"]),
          ),
        )
        .toList();
    _trackLength = rawAudioSource.length;
    _audioList = rawAudioSource;
    playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audioList,
    );
    playAudio(index);
    refreshOverlay(context, this);
  }

  void togglePlayPause() {
    _isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
    _isPlaying = !_isPlaying;
    notifyListeners();
    updateOverlay(this);
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    resetAudio();
    hideOverlay(this);
    notifyListeners();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  Stream<bool> get AudioPlayingStream => _audioPlayer.playingStream;
  Map<AudioInfoType, dynamic> get AudioInfo => {
        AudioInfoType.CurrentTrackIndex: _trackIndex,
        AudioInfoType.TotalTrackLength: _trackLength,
        AudioInfoType.IsPlaying: _isPlaying,
        AudioInfoType.MainTitle: _currentAudioTitle ?? "",
        AudioInfoType.SubTitle: _currentAudioSubTitle ?? "",
        AudioInfoType.MainCover: _mainCoverUrl ?? "",
        AudioInfoType.SamCover: _samCoverUrl ?? ""
      };
}
