// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:just_audio/just_audio.dart";
import "package:audio_service/audio_service.dart";
import "package:synchronized/synchronized.dart";

// function
import "package:kikoeru/pages/AudioOverlay/logic/OverlayHandler.dart";

// class
import "package:kikoeru/class/TrackInfo/models/TrackInfoMediaClass.dart";

enum AudioPlayerInfoType {
  PlayingStream,
  PositionStream,
  PlayerStateStream,
  SequenceStateStream,
  CurrentIndex,
  CurrentSource,
  IsPlaying,
  Speed,
  Position,
  Duration,
  BufferedPosition,
}

enum AudioInfoType { MainTitle, SubTitle, MainCover, SamCover, Lyrics }

class AudioProvider extends ChangeNotifier {
  AudioProvider() {
    _audioPlayer.sequenceStateStream.listen((state) {
      final tag = state?.currentSource?.tag;
      if (tag is MediaItem) {
        _setAudio(tag.title, tag.album ?? "");

        notifyListeners();
      }
    });
  }

  final Lock _lock = Lock();
  final AudioPlayer _audioPlayer = AudioPlayer();
  OverlayEntry? audioPlayerOverlayEntry;
  OverlayEntry? lyricsOverlayEntry;
  bool isFromPiP = false;

  String? _currentFolderTitle;
  String? _currentAudioTitle;
  String? _currentAudioSubTitle;
  String? _samCoverUrl;
  String? _mainCoverUrl;
  ConcatenatingAudioSource? playList;
  List<TypeMediaClass>? _lyrics;

  void _setAudio(String title, String subtitle) {
    _currentAudioTitle = title;
    _currentAudioSubTitle = subtitle;

    notifyListeners();
  }

  void _resetAudio() {
    _currentFolderTitle = null;
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

  Future<void> seek(Duration duration, {bool fromCurrent = false}) async {
    fromCurrent
        ? await _audioPlayer.seek(_audioPlayer.position + duration)
        : await _audioPlayer.seek(duration);
  }

  Future<void> _playAudio(int index) async {
    final needReload =
        _audioPlayer.sequenceState?.sequence != playList?.sequence ||
        _audioPlayer.currentIndex != index;

    if (needReload) {
      await _lock.synchronized(() async {
        await _audioPlayer.setAudioSource(
          playList!,
          initialIndex: index,
          initialPosition: Duration.zero,
        );
        _audioPlayer.play();
      });
    }

    notifyListeners();
  }

  void playAudioList(
    BuildContext context, {
    required String title,
    required int index,
    required List<TypeAudioClass> rawAudioSource,
    required String mainCoverUrl,
    required String samCoverUrl,
    required List<TypeMediaClass> subtitle,
  }) {
    if (title == _currentFolderTitle) {
      if (index != _audioPlayer.currentIndex) {
        _audioPlayer.seek(Duration.zero, index: index);
        _audioPlayer.play();

        updateOverlay(this);
      }
      return;
    }

    stopAudio();
    _currentFolderTitle = title;
    _mainCoverUrl = mainCoverUrl;
    _samCoverUrl = samCoverUrl;
    List<UriAudioSource> audioList =
        rawAudioSource
            .map(
              (item) => AudioSource.uri(
                Uri.parse(
                  item.streamLowQualityUrl.toString().isNotEmpty
                      ? item.streamLowQualityUrl
                      : item.mediaStreamUrl,
                ),
                tag: MediaItem(
                  id: item.hash,
                  album: item.workTitle,
                  title: item.title,
                  artUri: Uri.parse(mainCoverUrl),
                ),
              ),
            )
            .toList();
    playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audioList,
    );
    _lyrics = subtitle;

    _playAudio(index);
    refreshOverlay(context, this);
  }

  Future<void> togglePlayPause() async {
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
    AudioPlayerInfoType.PlayerStateStream: _audioPlayer.playerStateStream,
    AudioPlayerInfoType.SequenceStateStream: _audioPlayer.sequenceStateStream,
    AudioPlayerInfoType.CurrentIndex: _audioPlayer.currentIndex,
    AudioPlayerInfoType.CurrentSource:
        _audioPlayer.sequenceState?.currentSource,
    AudioPlayerInfoType.IsPlaying: _audioPlayer.playing,
    AudioPlayerInfoType.Speed: _audioPlayer.speed,
    AudioPlayerInfoType.Position: _audioPlayer.position,
    AudioPlayerInfoType.Duration: _audioPlayer.duration,
    AudioPlayerInfoType.BufferedPosition: _audioPlayer.bufferedPosition,
  };

  Map<AudioInfoType, dynamic> get AudioInfo => {
    AudioInfoType.MainTitle: _currentAudioTitle ?? "載入中...",
    AudioInfoType.SubTitle: _currentAudioSubTitle ?? "正在載入音樂",
    AudioInfoType.MainCover: _mainCoverUrl ?? "",
    AudioInfoType.SamCover: _samCoverUrl ?? "",
    AudioInfoType.Lyrics: _lyrics ?? [],
  };
}
