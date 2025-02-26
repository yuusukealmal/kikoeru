import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/pages/SearchPage.dart';

String calcDuration(int duration, {bool isDetail = false}) {
  if (isDetail) {
    int hr = duration ~/ 3600;
    int min = (duration % 3600) ~/ 60;
    int sec = (duration % 3600) % 60;
    return "($hr:$min:$sec)";
  } else {
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

dynamic getSubtitle(bool hasSubtitle) {
  if (hasSubtitle) {
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
  } else {
    return [];
  }
}

dynamic getMutiLang(List<dynamic> langs, {bool isDetail = false}) {
  if (langs.isNotEmpty) {
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
          "多語言",
          style: const TextStyle(
              fontSize: 12, color: Color.fromARGB(255, 11, 155, 244)),
        ),
      ),
      if (isDetail)
        ...langs.map(
          (lang) {
            return Text(
              lang["lang"],
              style: const TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 11, 155, 244)),
            );
          },
        ),
    ];
  } else {
    return [];
  }
}

Widget getTagWidget(BuildContext context, String tag) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchWorksPage(
            type: SearchType.Tag,
            query: tag,
          ),
        ),
      );
    },
  );
}
