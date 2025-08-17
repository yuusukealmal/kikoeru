// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/models/Work.dart';

// api
import 'package:kikoeru/api/WorkRequest/httpRequests.dart';

// pages
import 'package:kikoeru/pages/HomePage/pages/SearchPage.dart';

Widget getTagWidget(BuildContext context, (String, int) tag) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(tag.$1,
          style: tag.$2 == 0
              ? TextStyle(
                  color: Color.fromARGB(140, 255, 255, 255),
                  decoration: TextDecoration.underline,
                )
              : TextStyle(color: Colors.white, fontSize: 15)),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchWorksPage(
            type: SearchType.Tag,
            query: tag.$1,
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
      children: work.Tags.map(
              (tag) => (tag?["i18n"]["zh-cn"]["name"], tag?["voteStatus"]))
          .where((tag) => tag.$1.isNotEmpty)
          .map((tag) => getTagWidget(context, tag as (String, int)))
          .toList(),
    ),
  );
}
