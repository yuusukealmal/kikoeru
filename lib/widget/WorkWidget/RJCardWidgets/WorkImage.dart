import 'package:flutter/material.dart';

import 'package:kikoeru/class/workInfo.dart';

Widget getWorkImage(Work work) {
  return Image.network(
    work.mainCoverUrl,
    fit: BoxFit.cover,
  );
}
