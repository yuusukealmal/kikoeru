import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/pages/HomePage/SearchPage.dart';

Widget getTitleandCircle(BuildContext context, Work work) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          work.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
