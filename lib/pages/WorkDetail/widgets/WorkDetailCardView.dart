// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/models/Work.dart';

// card detail widgets
import 'package:kikoeru/class/CardWidgets/WorkImage.dart';
import 'package:kikoeru/class/CardWidgets/WorkRjID.dart';
import 'package:kikoeru/class/CardWidgets/ReleaseDate.dart';
import 'package:kikoeru/class/CardWidgets/TitleCircle.dart';
import 'package:kikoeru/class/CardWidgets/Rate.dart';
import 'package:kikoeru/class/CardWidgets/Sell.dart';
import 'package:kikoeru/class/CardWidgets/Age.dart';
import 'package:kikoeru/class/CardWidgets/MutiLang.dart';
import 'package:kikoeru/class/CardWidgets/Subtitle.dart';
import 'package:kikoeru/class/CardWidgets/Tag.dart';
import 'package:kikoeru/class/CardWidgets/Va.dart';

class WorkDetailCardView extends StatelessWidget {
  const WorkDetailCardView({super.key, required this.work});
  final Work work;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
