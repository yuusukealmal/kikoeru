// flutter
import "package:flutter/material.dart";

// pages
import "package:kikoeru/pages/AudioPlayer/pages/AudioPlayer.dart";

Widget openFullPlayerButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.keyboard_arrow_up_sharp,
    ),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioPlayerScreen(),
      ),
    ),
  );
}
