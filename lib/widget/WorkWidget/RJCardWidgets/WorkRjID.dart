import 'package:flutter/material.dart';
import 'package:kikoeru/class/workInfo.dart';

Widget getWorkRJID(Work work, {double top = 8, double left = 8}) {
  return Positioned(
    top: top,
    left: left,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 121, 85, 72),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "RJ${work.id}",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
