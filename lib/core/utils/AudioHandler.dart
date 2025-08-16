// 3rd lib
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

class MyAudioHandler extends BaseAudioHandler {
  final AudioProvider audioProvider;

  MyAudioHandler(this.audioProvider) {
    audioProvider.AudioPlayerInfo[AudioPlayerInfoType.PlayerStateStream]
        .listen(_broadcastState);

    audioProvider.AudioPlayerInfo[AudioPlayerInfoType.PositionStream].listen(
        (_) => _broadcastState(audioProvider
            .AudioPlayerInfo[AudioPlayerInfoType.PlayerStateStream].value));

    audioProvider.AudioPlayerInfo[AudioPlayerInfoType.SequenceStateStream]
        .listen((sequenceState) {
      final tag = sequenceState?.currentSource?.tag;
      if (tag is MediaItem) {
        mediaItem.add(tag);
      }
    });
  }

  void _broadcastState(PlayerState state) {
    final playing = state.playing;
    final processingState = state.processingState;

    playbackState.add(PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        playing ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext,
        MediaControl.stop,
      ],
      androidCompactActionIndices: const [0, 1, 2],
      processingState: _mapProcessingState(processingState),
      playing: playing,
      updatePosition:
          audioProvider.AudioPlayerInfo[AudioPlayerInfoType.Position],
      bufferedPosition:
          audioProvider.AudioPlayerInfo[AudioPlayerInfoType.BufferedPosition],
      speed: audioProvider.AudioPlayerInfo[AudioPlayerInfoType.Speed],
      queueIndex:
          audioProvider.AudioPlayerInfo[AudioPlayerInfoType.CurrentIndex],
    ));

    final currentSource =
        audioProvider.AudioPlayerInfo[AudioPlayerInfoType.CurrentSource];
    if (currentSource?.tag is MediaItem) {
      final currentMediaItem = currentSource!.tag as MediaItem;
      final duration =
          audioProvider.AudioPlayerInfo[AudioPlayerInfoType.Duration];

      mediaItem.add(currentMediaItem.copyWith(
        duration: duration,
      ));
    }
  }

  AudioProcessingState _mapProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  @override
  Future<void> play() => audioProvider.togglePlayPause();

  @override
  Future<void> pause() => audioProvider.togglePlayPause();

  @override
  Future<void> skipToNext() =>
      audioProvider.hasNext ? audioProvider.nextTrack() : Future.value();

  @override
  Future<void> skipToPrevious() => audioProvider.hasPrevious
      ? audioProvider.previousTrack()
      : Future.value();

  @override
  Future<void> stop() => audioProvider.stopAudio();
}
