// flutter
import "dart:convert";

import "package:flutter/material.dart";

// api
import "package:kikoeru/api/WorkRequest/httpRequests.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";
import "package:kikoeru/class/WorkInfo/models/OtherLangInDBClass.dart";

// pages
import "package:kikoeru/pages/WorkDetail/pages/WorkDetailPage.dart";

Widget getMutiLang(BuildContext context, List<OtherlanginDBClass> langs,
    {bool isDetail = false}) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
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
            fontSize: 12,
            color: Color.fromARGB(255, 11, 155, 244),
          ),
        ),
      ),
      if (isDetail)
        ...langs.map(
          (lang) {
            return GestureDetector(
              onTap: () async {
                final workInfo = await Request.getWorkInfo(lang.ID.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkPage(
                      work: WorkInfo(work: jsonDecode(workInfo)),
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 1.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 11, 155, 244),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Text(
                  lang.lang,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 11, 155, 244),
                  ),
                ),
              ),
            );
          },
        ),
    ],
  );
}
