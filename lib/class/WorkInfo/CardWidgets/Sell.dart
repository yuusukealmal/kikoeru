// flutter
import "package:flutter/material.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

Widget getSell(WorkInfo work) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 8.0,
    children: [
      SizedBox(width: 1),
      Text(
        "${work.price} JPY",
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      Text(
        "銷量: ${work.dlCount}",
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
