// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:url_launcher/url_launcher.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

// utils
import "package:kikoeru/core/utils/DurationCalc.dart";

// widgets
import "package:kikoeru/class/WorkInfo/CardWidgets/Star.dart";

String getSourceType(String sourceType) {
  switch (sourceType.toLowerCase()) {
    case "dlsite":
      return "DLsite";
    default:
      throw Exception("Unknown source type");
  }
}

Widget getRate(WorkInfo work, {bool isDetail = false}) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      SizedBox(width: 1),
      StarRating(work: work),
      Text(
        work.rateAverage2dp.toString(),
        style: const TextStyle(
            fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
      ),
      Text(
        "(${work.rateCount})",
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 130, 130, 130),
        ),
      ),
      Icon(
        Icons.message,
        size: 16,
        color: const Color.fromARGB(153, 255, 255, 255),
      ),
      Text(
        "(${work.reviewCount})",
        style: const TextStyle(
          fontSize: 14,
          // color: Color.fromARGB(255, 130, 130, 130),
        ),
      ),
      Icon(
        Icons.access_time,
        size: 16,
        // color: const Color.fromARGB(180, 255, 255, 255),
      ),
      Text(
        duration2Display(work.duration, isDetail: isDetail),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Icon(
        Icons.open_in_new,
        size: 16,
        // color: const Color.fromARGB(180, 255, 255, 255),
      ),
      InkWell(
        onTap: () {
          launchUrl(
            Uri.parse(work.sourceURL),
          );
        },
        child: Text(
          getSourceType(work.sourceType),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 32, 129, 206),
          ),
        ),
      ),
    ],
  );
}
