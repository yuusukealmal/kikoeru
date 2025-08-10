// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/models/Work.dart';

// pages
import 'package:kikoeru/pages/WorkDetail/pages/WorkDetailPage.dart';

Widget HomePageCardView(List<dynamic> works) {
  return Expanded(
    child: ListView.builder(
      itemCount: works.length,
      itemBuilder: (context, index) {
        final Work work = Work(work: works[index]);
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
