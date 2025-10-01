// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:provider/provider.dart";

// config
import "package:kikoeru/core/config/provider/AudioProvider.dart";

// pages
import "package:kikoeru/pages/AudioOverlay/logic/OverlayHandler.dart";

mixin AudioPlayerOverlayRouteAware<T extends StatefulWidget> on State<T>
    implements RouteAware {
  @override
  void didPush() {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    hideOverlay(audioProvider, isClose: false);
  }

  @override
  void didPopNext() {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    if (audioProvider.AudioPlayerInfo[AudioPlayerInfoType.IsPlaying]) {
      if (audioProvider.isFromPiP) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (audioProvider.AudioInfo[AudioInfoType.Lyrics] != null &&
              audioProvider.AudioInfo[AudioInfoType.Lyrics]!.isNotEmpty) {
            setLyricsOverlay(context, audioProvider);
          }
        });
        audioProvider.isFromPiP = false;
      } else {
        refreshOverlay(context, audioProvider);
      }
    }
  }

  @override
  void didPop() {
    // 當前路由被彈出時
  }

  @override
  void didPushNext() {
    // 當前路由被覆蓋時
  }
}
