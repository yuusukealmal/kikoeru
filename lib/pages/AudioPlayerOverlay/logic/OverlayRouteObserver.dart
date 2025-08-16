// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';

// pages
import 'package:kikoeru/pages/AudioPlayerOverlay/logic/OverlayLogic.dart';

mixin OverlayRouteAware<T extends StatefulWidget> on State<T>
    implements RouteAware {
  @override
  void didPush() {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    hideOverlay(audioProvider);
  }

  @override
  void didPopNext() {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    if (audioProvider.AudioPlayerInfo[AudioPlayerInfoType.IsPlaying]) {
      refreshOverlay(context, audioProvider);
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
