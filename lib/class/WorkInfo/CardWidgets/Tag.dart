// flutter
import "package:flutter/material.dart";

// frb
import "package:kikoeru/src/rust/api/requests/config/types.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";
import "package:kikoeru/class/WorkInfo/models/TagClass.dart";

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
      child:
          tag.voteStatus == 0
              ? Container(
                padding: EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(140, 255, 255, 255),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  tag.i18n.zhCn.name,
                  style: TextStyle(color: Color.fromARGB(140, 255, 255, 255)),
                ),
              )
              : Text(
                tag.i18n.zhCn.name,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => SearchWorksPage(
                type: SearchType.tag,
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
      children:
          work.tags
              .where((tag) => tag.i18n.zhCn.name.isNotEmpty)
              .map((tag) => getTagWidget(context, tag))
              .toList(),
    ),
  );
}
