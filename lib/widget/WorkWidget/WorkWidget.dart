import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/pages/SearchPage.dart';
import 'package:kikoeru/functions/CardCalc.dart';

mixin WorkWidget {
  static Widget getWorkImage(Work work) {
    return Image.network(
      work.mainCoverUrl,
      fit: BoxFit.cover,
    );
  }

  static Widget getWorkRJID(Work work, {double top = 8, double left = 8}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 121, 85, 72),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          "RJ${work.id}",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Widget getWorkReleaseDate(Work work) {
    return Positioned(
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
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Widget getTitleandCircle(BuildContext context, Work work) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            work.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          GestureDetector(
            child: Text(
              work.name,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchWorksPage(
                    type: SearchType.Circle,
                    query: work.name,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  static Widget getRate(Work work, {bool isDetail = false}) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        SizedBox(width: 1),
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
            fontSize: 14,
            // color: Color.fromARGB(255, 130, 130, 130),
          ),
        ),
        Icon(
          CupertinoIcons.clock_solid,
          size: 16,
          // color: const Color.fromARGB(180, 255, 255, 255),
        ),
        Text(
          calcDuration(work.duration, isDetail: isDetail),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.open_in_new,
          size: 16,
          // color: const Color.fromARGB(180, 255, 255, 255),
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 32, 129, 206),
            ),
          ),
        ),
      ],
    );
  }

  static Widget getSell(Work work, {bool isDetail = false}) {
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

  static Widget getTag(BuildContext context, Work work) {
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

  static Widget getVas(BuildContext context, Work work) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: work.Vas.map((va) => va["name"].toString())
            .toList()
            .map(
              (cv) => GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 150, 136),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    cv,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchWorksPage(
                        type: SearchType.VAS,
                        query: cv,
                      ),
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
