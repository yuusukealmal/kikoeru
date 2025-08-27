// flutter
import "package:flutter/material.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

// card detail wodgets
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

class HomePageWrokCard extends StatefulWidget {
  const HomePageWrokCard({super.key, required this.work});

  final WorkInfo work;

  @override
  State<HomePageWrokCard> createState() => _HomePageWrokCardState();
}

class _HomePageWrokCardState extends State<HomePageWrokCard> {
  @override
  Widget build(BuildContext context) {
    WorkInfo work = widget.work;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),

          // 上方圖片區塊 (含 ID 標籤)
          Center(
            child: Stack(
              children: [
                getWorkImage(work),
                getWorkRJID(work),
                getWorkReleaseDate(work)
              ],
            ),
          ),

          // 作品資訊
          getTitleandCircle(context, work),

          // 作品統計資訊
          getRate(work),

          // 價格和銷量
          Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              getSell(work),
              if (work.ageCategoryString.isNotEmpty &&
                  work.ageCategoryString != "adult")
                getAgeString(work.ageCategoryString),
              if (work.hasSubTitle) getSubtitle(work.hasSubTitle),
              if (work.otherLangEditionsInDB.isNotEmpty)
                getMutiLang(context, work.otherLangEditionsInDB),
            ],
          ),

          SizedBox(height: 8),

          // 標籤區塊
          getTag(context, work),

          SizedBox(height: 8),

          // cv 區塊
          getVas(context, work),

          SizedBox(height: 16)
        ],
      ),
    );
  }
}
