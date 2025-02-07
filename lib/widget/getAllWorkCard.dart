import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/functions/CardCalc.dart';

Widget getAllWorkCard(Work work) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 上方圖片區塊 (含 ID 標籤)
        Stack(
          children: [
            Image.network(
              work.mainCoverUrl,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 121, 85, 72),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "RJ${work.id}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(100, 0, 0, 0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  work.release,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),

        // 作品資訊
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                work.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                work.name,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            getStarRating(work.Rate),
            Text(
              work.Rate.toString(),
              style: const TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              "(${work.RateCount})",
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
            ),
            Icon(
              Icons.message,
              size: 16,
              color: const Color.fromARGB(153, 255, 255, 255),
            ),
            Text(
              "(${work.ReviewCount})",
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 130, 130, 130),
              ),
            ),
            Icon(
              CupertinoIcons.clock_solid,
              size: 16,
              color: const Color.fromARGB(180, 255, 255, 255),
            ),
            Text(
              calcDuration(work.duration),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.open_in_new,
              size: 16,
              color: const Color.fromARGB(180, 255, 255, 255),
            ),
            InkWell(
              onTap: () {
                launchUrl(
                  Uri.parse(work.sourceURL),
                );
              },
              child: Text(
                "DLsite",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 32, 129, 206),
                ),
              ),
            ),
          ],
        ),
        //價錢
        Wrap(
          spacing: 6,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(
              "${work.price} JPY",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              "銷量: ${work.dlCount}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...getAgeString(work.AgeCategory),
            ...getTrans(work.Lang),
          ],
        ),
        SizedBox(height: 8),
        // 標籤區塊
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children:
                work.Tags.map((tag) => tag?["i18n"]["zh-cn"]["name"] ?? "")
                    .where((tag) => tag.isNotEmpty)
                    .map((tag) => getTagWidget(tag))
                    .toList(),
          ),
        ),
        SizedBox(height: 8),
        //cv
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: work.Vas.map((va) => va["name"].toString())
                .toList()
                .map(
                  (cv) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 150, 136),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      cv,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}
