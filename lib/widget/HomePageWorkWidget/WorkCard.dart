// flutter
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/Work.dart';

// card detail wodgets
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

class WrokCard extends StatefulWidget {
  const WrokCard({super.key, required this.work});

  final Work work;

  @override
  State<WrokCard> createState() => _WrokCardState();
}

class _WrokCardState extends State<WrokCard> {
  @override
  Widget build(BuildContext context) {
    Work work = widget.work;
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
              ...getSell(work),
              ...getAgeString(work.AgeCategory),
              ...getSubtitle(work.HasSubTitle),
              ...getMutiLang(work.OtherLang, isDetail: false),
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
