// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/WorkInfo/WorkInfo.dart';

Widget getWorkReleaseDate(WorkInfo work) {
  return Positioned(
    bottom: 4,
    right: 8,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(100, 0, 0, 0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        work.release,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
