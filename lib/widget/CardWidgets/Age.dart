// flutter
import 'package:flutter/material.dart';

List<Widget> getAgeString(String ageCategory) {
  switch (ageCategory) {
    case "general":
      return [
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 76, 175, 80),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            "全年齡",
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 76, 175, 80),
            ),
          ),
        )
      ];
    case "r15":
      return [
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 255, 152, 0),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            "R-15",
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 255, 152, 0),
            ),
          ),
        )
      ];
    default:
      return [];
  }
}
