import "package:flutter/widgets.dart";

void resetScroll(ScrollController scrollController) {
  if (scrollController.hasClients) {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
