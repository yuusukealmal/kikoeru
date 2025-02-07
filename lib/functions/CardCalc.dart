import 'package:flutter/material.dart';

String calcDuration(int duration) {
  int hr = duration ~/ 3600;
  if (hr > 0) {
    return "(${(duration / 3600).toStringAsFixed(1)})hr";
  }
  int min = (duration % 3600) ~/ 60;
  if (min > 0) {
    return "(${min}min)";
  }
  return "(${duration}s)";
}

dynamic getStarRating(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      if (index < rating) {
        if (rating - index >= 1) {
          return Icon(Icons.star, size: 22, color: Colors.amber);
        } else {
          return Icon(Icons.star_half, size: 22, color: Colors.amber);
        }
      } else {
        return Icon(Icons.star_border, size: 22, color: Colors.amber);
      }
    }),
  );
}

dynamic getAgeString(String ageCategory) {
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
              fontSize: 10,
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
              fontSize: 10,
              color: Color.fromARGB(255, 255, 152, 0),
            ),
          ),
        )
      ];
    default:
      return [];
  }
}

dynamic getTrans(dynamic trans) {
  try {
    if (trans.isNotEmpty) {
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
                fontSize: 10, color: Color.fromARGB(255, 11, 155, 244)),
          ),
        )
      ];
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Widget getTagWidget(String tag) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      tag,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}
