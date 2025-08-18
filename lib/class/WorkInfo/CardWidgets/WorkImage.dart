// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/WorkInfo/WorkInfo.dart';

Widget getWorkImage(WorkInfo work) {
  return Image.network(
    work.mainCoverUrl,
    fit: BoxFit.cover,
  );
}
