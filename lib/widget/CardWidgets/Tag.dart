// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/Work.dart';

// api
import 'package:kikoeru/api/WorkRequest/httpRequests.dart';

// pages
import 'package:kikoeru/pages/HomePage/SearchPage.dart';

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

Widget getTag(BuildContext context, Work work) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Wrap(
      spacing: 6,
      runSpacing: 4,
      children: work.Tags.map((tag) => tag?["i18n"]["zh-cn"]["name"] ?? "")
          .where((tag) => tag.isNotEmpty)
          .map((tag) => getTagWidget(context, tag))
          .toList(),
    ),
  );
}
