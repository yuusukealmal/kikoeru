// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:just_audio/just_audio.dart';
import 'package:synchronized/synchronized.dart';

// function
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayLogic.dart';

enum AudioInfoType {
  CurrentTrackIndex,
  IsPlaying,
  MainTitle,
  SubTitle,
  MainCover,
  SamCover
}

enum AudioPlayerInfoType { PlayingStream, PositionStream, Duration }

class AudioProvider extends ChangeNotifier {
  AudioProvider() {
    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _setAudio(
          _audioList?[index]["title"],
          _audioList?[index]["workTitle"],
        );

        notifyListeners();
      }
    });
  }

  final Lock _lock = Lock();
  final AudioPlayer _audioPlayer = AudioPlayer();
  OverlayEntry? overlayEntry;

  String? _currentAudioTitle;
  String? _currentAudioSubTitle;
  String? _samCoverUrl;
  String? _mainCoverUrl;
  ConcatenatingAudioSource? playList;
  List<Map<String, dynamic>>? _audioList;

  void _setAudio(String? title, String? subtitle) {
    _currentAudioTitle = title;
    _currentAudioSubTitle = subtitle;

    notifyListeners();
  }

  void _resetAudio() {
    _currentAudioTitle = null;
    _currentAudioSubTitle = null;
  }

  Future<void> previousTrack() async {
    await _audioPlayer.seekToPrevious();
    _audioPlayer.play();

    notifyListeners();
  }

  Future<void> nextTrack() async {
    await _audioPlayer.seekToNext();
    _audioPlayer.play();

    notifyListeners();
  }

  Future<void> seek(Duration duration) async {
    await _audioPlayer.seek(_audioPlayer.position + duration);
  }

  Future<void> _playAudio(int index) async {
    if (_audioPlayer.currentIndex != index) {
      await _lock.synchronized(() async {
        await stopAudio();
        await _audioPlayer.setAudioSource(
          playList!,
          initialIndex: index,
          initialPosition: Duration.zero,
        );

        _audioPlayer.play();
      });
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
    _mainCoverUrl = mainCoverUrl;
    _samCoverUrl = samCoverUrl;
    List<UriAudioSource> audioList = rawAudioSource
        .map(
          (item) => AudioSource.uri(
            Uri.parse(item["streamLowQualityUrl"] ?? item["mediaStreamUrl"]),
          ),
        )
        .toList();
    _audioList = rawAudioSource;
    playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audioList,
    );

    _playAudio(index);
    refreshOverlay(context, this);
  }

  void togglePlayPause() {
    _audioPlayer.playing ? _audioPlayer.pause() : _audioPlayer.play();

    notifyListeners();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _resetAudio();
    hideOverlay(this);

    notifyListeners();
  }

  bool get hasPrevious => _audioPlayer.previousIndex != null;
  bool get hasNext => _audioPlayer.nextIndex != null;

  Map<AudioPlayerInfoType, dynamic> get AudioPlayerInfo => {
        AudioPlayerInfoType.PlayingStream: _audioPlayer.playingStream,
        AudioPlayerInfoType.PositionStream: _audioPlayer.positionStream,
        AudioPlayerInfoType.Duration: _audioPlayer.duration
      };

  Map<AudioInfoType, dynamic> get AudioInfo => {
        AudioInfoType.CurrentTrackIndex: _audioPlayer.currentIndex,
        AudioInfoType.IsPlaying: _audioPlayer.playing,
        AudioInfoType.MainTitle: _currentAudioTitle ?? "載入中...",
        AudioInfoType.SubTitle: _currentAudioSubTitle ?? "正在載入音樂",
        AudioInfoType.MainCover: _mainCoverUrl ?? "",
        AudioInfoType.SamCover: _samCoverUrl ?? ""
      };
}
