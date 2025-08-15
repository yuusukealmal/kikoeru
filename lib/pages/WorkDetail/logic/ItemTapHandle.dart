// flutter
import 'package:flutter/material.dart';

import 'package:kikoeru/pages/WorkDetail/pages/ItemImageView.dart';
import 'package:kikoeru/pages/WorkDetail/widgets/ItemPdfView.dart';
import 'package:kikoeru/pages/WorkDetail/widgets/ItemTextView.dart';

mixin ItemTap {
  void handleItemTap(BuildContext context, Map<String, dynamic> item) {
    switch (item["type"]) {
      case "text":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemTextView(
              item["title"],
              item["mediaStreamUrl"],
            ),
          ),
        );
        break;
      case "image":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemImageView(
              title: item["title"],
              url: item["mediaStreamUrl"],
            ),
          ),
        );
        break;
      case "other":
        if (item["title"].endsWith(".pdf")) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemPdfView(
                item["title"],
                item["mediaStreamUrl"],
              ),
            ),
          );
        }
        break;
    }
  }
}
