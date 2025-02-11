import 'package:flutter/material.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/widget/WorkWidget/WorkWidget.dart';

Widget getAllWorkCard(Work work) {
  return FractionallySizedBox(
    widthFactor: 0.95,
    heightFactor: 0.95,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 上方圖片區塊 (含 ID 標籤)
            Stack(
              children: [
                WorkWidget.getWorkImage(work),
                WorkWidget.getWorkRJID(work),
                WorkWidget.getWorkReleaseDate(work)
              ],
            ),

            // 作品資訊
            WorkWidget.getTitleandCircle(work),

            // 作品統計資訊
            WorkWidget.getRate(work),

            // 價格和銷量
            WorkWidget.getSell(work),

            SizedBox(height: 8),

            // 標籤區塊
            WorkWidget.getTag(work),

            SizedBox(height: 8),

            // cv 區塊
            WorkWidget.getVas(work),
          ],
        ),
      ),
    ),
  );
}
