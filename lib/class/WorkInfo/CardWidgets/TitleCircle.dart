// flutter
import 'package:flutter/material.dart';

// api
import 'package:kikoeru/api/WorkRequest/httpRequests.dart';

// class
import 'package:kikoeru/class/WorkInfo/WorkInfo.dart';

// pages
import 'package:kikoeru/pages/HomePage/pages/SearchPage.dart';

Widget getTitleandCircle(BuildContext context, WorkInfo work) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          work.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          child: Text(
            work.name,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchWorksPage(
                  type: SearchType.Circle,
                  query: work.name,
                ),
              ),
            );
          },
        )
      ],
    ),
  );
}
