// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/models/Work.dart';

List<Widget> getSell(Work work) {
  return [
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
  ];
}
