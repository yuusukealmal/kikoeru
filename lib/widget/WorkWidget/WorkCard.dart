import 'package:flutter/material.dart';
import 'package:kikoeru/class/workInfo.dart';

// card detail
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/WorkImage.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/WorkRjID.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/ReleaseDate.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/TitleCircle.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Rate.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Sell.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Tag.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Va.dart';

class WrokCard extends StatefulWidget {
  const WrokCard({super.key, required this.work});

  final Work work;

  @override
  State<WrokCard> createState() => _WrokCardState();
}

class _WrokCardState extends State<WrokCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          getSell(work),

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
