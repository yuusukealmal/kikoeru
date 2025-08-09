import 'package:flutter/material.dart';

import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/pages/Work.dart';

Widget HomePageCardView(List<dynamic> works) {
  return Expanded(
    child: ListView.builder(
      itemCount: works.length,
      itemBuilder: (context, index) {
        final Work work = Work(work: works[index]);
        return GestureDetector(
          child: work.AllWorkCard(),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkPage(work: work)),
          ),
        );
      },
    ),
  );
}
