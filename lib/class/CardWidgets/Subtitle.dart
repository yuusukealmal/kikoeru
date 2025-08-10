// flutter
import 'package:flutter/material.dart';

List<Widget> getSubtitle(bool hasSubtitle) {
  if (!hasSubtitle) return [];

  return [
    Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 11, 155, 244),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        "帶字幕",
        style: const TextStyle(
            fontSize: 12, color: Color.fromARGB(255, 11, 155, 244)),
      ),
    )
  ];
}
