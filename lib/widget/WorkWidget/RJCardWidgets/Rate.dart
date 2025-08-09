import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/functions/CardCalc.dart';

Widget getRate(Work work, {bool isDetail = false}) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      SizedBox(width: 1),
      getStarRating(work.Rate),
      Text(
        work.Rate.toString(),
        style: const TextStyle(
            fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
      ),
      Text(
        "(${work.RateCount})",
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
        "(${work.ReviewCount})",
        style: const TextStyle(
          fontSize: 14,
          // color: Color.fromARGB(255, 130, 130, 130),
        ),
      ),
      Icon(
        CupertinoIcons.clock_solid,
        size: 16,
        // color: const Color.fromARGB(180, 255, 255, 255),
      ),
      Text(
        calcDuration(work.duration, isDetail: isDetail),
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
          "DLsite",
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
