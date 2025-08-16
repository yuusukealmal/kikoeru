// 3rd liv
import 'package:audio_service/audio_service.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

class MyAudioHandler extends BaseAudioHandler {
  final AudioProvider audioProvider;

  MyAudioHandler(this.audioProvider);

  @override
  Future<void> play() async {
    audioProvider.togglePlayPause();
  }

  @override
  Future<void> pause() async {
    audioProvider.togglePlayPause();
  }

  @override
  Future<void> skipToNext() async {
    if (audioProvider.hasNext) {
      await audioProvider.nextTrack();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (audioProvider.hasPrevious) {
      await audioProvider.previousTrack();
    }
  }

  @override
  Future<void> stop() async {
    await audioProvider.stopAudio();
  }
}
