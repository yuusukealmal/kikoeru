// flutter
import "package:flutter/material.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";
import "package:kikoeru/class/WorkInfo/models/TagClass.dart";

// api
import "package:kikoeru/api/WorkRequest/httpRequests.dart";

// pages
import "package:kikoeru/pages/HomePage/pages/SearchPage.dart";

Widget getTagWidget(BuildContext context, TagClass tag) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag.i18n.zhCn.name,
        style: tag.voteStatus == 0
            ? TextStyle(
                color: Color.fromARGB(140, 255, 255, 255),
                decoration: TextDecoration.underline,
              )
            : TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchWorksPage(
            type: SearchType.Tag,
            query: tag.i18n.zhCn.name,
          ),
        ),
      );
    },
  );
}

Widget getTag(BuildContext context, WorkInfo work) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Wrap(
      spacing: 6,
      runSpacing: 4,
      children: work.tags
          .where((tag) => tag.i18n.zhCn.name.isNotEmpty)
          .map((tag) => getTagWidget(context, tag))
          .toList(),
    ),
  );
}
