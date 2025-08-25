// flutter
import "package:flutter/material.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

// card detail widgets
import "package:kikoeru/class/WorkInfo/CardWidgets/WorkImage.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/WorkRjID.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/ReleaseDate.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/TitleCircle.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/Rate.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/Sell.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/Age.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/MutiLang.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/Subtitle.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/Tag.dart";
import "package:kikoeru/class/WorkInfo/CardWidgets/Va.dart";

class WorkDetailCardView extends StatelessWidget {
  const WorkDetailCardView({super.key, required this.work});

  final WorkInfo work;

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
            getSell(work),
            getAgeString(work.ageCategoryString),
            getSubtitle(work.hasSubTitle),
            getMutiLang(work.otherLangEditionsInDB, isDetail: false),
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
