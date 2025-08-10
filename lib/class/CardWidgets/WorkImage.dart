// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/models/Work.dart';

Widget getWorkImage(Work work) {
  return Image.network(
    work.mainCoverUrl,
    fit: BoxFit.cover,
  );
}
