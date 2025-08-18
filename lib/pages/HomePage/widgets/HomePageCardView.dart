// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/WorkInfo/WorkInfo.dart';

// pages
import 'package:kikoeru/pages/WorkDetail/pages/WorkDetailPage.dart';

Widget HomePageCardView(
  List<dynamic> works,
  ScrollController scrollController,
) {
  return Expanded(
    child: ListView.builder(
      controller: scrollController,
      itemCount: works.length,
      itemBuilder: (context, index) {
        final WorkInfo work = WorkInfo(work: works[index]);
        return GestureDetector(
          child: work.HomePageWorkCard(),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkPage(work: work)),
          ),
        );
      },
    ),
  );
}
