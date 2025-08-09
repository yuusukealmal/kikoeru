import 'package:flutter/material.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/functions/CardCalc.dart';

Widget getSell(Work work, {bool isDetail = false}) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    crossAxisAlignment: WrapCrossAlignment.end,
    children: [
      SizedBox(width: 1),
      Text(
        "${work.price} JPY",
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      Text(
        "銷量: ${work.dlCount}",
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      ...getAgeString(work.AgeCategory),
      ...getSubtitle(work.HasSubTitle),
      ...getMutiLang(work.OtherLang, isDetail: isDetail),
    ],
  );
}
