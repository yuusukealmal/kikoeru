// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/Work.dart';

// card detail widgets
import 'package:kikoeru/widget/CardWidgets/WorkImage.dart';
import 'package:kikoeru/widget/CardWidgets/WorkRjID.dart';
import 'package:kikoeru/widget/CardWidgets/ReleaseDate.dart';
import 'package:kikoeru/widget/CardWidgets/TitleCircle.dart';
import 'package:kikoeru/widget/CardWidgets/Rate.dart';
import 'package:kikoeru/widget/CardWidgets/Sell.dart';
import 'package:kikoeru/widget/CardWidgets/Age.dart';
import 'package:kikoeru/widget/CardWidgets/MutiLang.dart';
import 'package:kikoeru/widget/CardWidgets/Subtitle.dart';
import 'package:kikoeru/widget/CardWidgets/Tag.dart';
import 'package:kikoeru/widget/CardWidgets/Va.dart';

List<Widget> WorkDetailCardView(BuildContext context, Work work) {
  return [
    Stack(
      children: [
        getWorkImage(work),
        getWorkRJID(work, top: 12, left: 14),
        getWorkReleaseDate(work),
      ],
    ),
    getTitleandCircle(context, work),
    getRate(work, isDetail: true),
    const SizedBox(height: 8),
    Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        ...getSell(work),
        ...getAgeString(work.AgeCategory),
        ...getSubtitle(work.HasSubTitle),
        ...getMutiLang(work.OtherLang, isDetail: false),
      ],
    ),
    const SizedBox(height: 8),
    getTag(context, work),
    const SizedBox(height: 8),
    getVas(context, work),
    const SizedBox(height: 8),
  ];
}
