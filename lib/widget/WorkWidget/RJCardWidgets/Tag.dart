import 'package:flutter/material.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/functions/CardCalc.dart';

Widget getTag(BuildContext context, Work work) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Wrap(
      spacing: 6,
      runSpacing: 4,
      children: work.Tags.map((tag) => tag?["i18n"]["zh-cn"]["name"] ?? "")
          .where((tag) => tag.isNotEmpty)
          .map((tag) => getTagWidget(context, tag))
          .toList(),
    ),
  );
}
