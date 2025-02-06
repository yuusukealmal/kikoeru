import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final List<String> cvs;
  final String date;
  final String circle;
  final List<dynamic> tags;
  final int duration;
  final int price;
  final int selled;
  final double rating;
  final int rateCount;
  final int reviewCount;
  final String url;
  final String ageCategory;

  const WorkCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.cvs,
    required this.date,
    required this.circle,
    required this.tags,
    required this.duration,
    required this.price,
    required this.selled,
    required this.rating,
    required this.rateCount,
    required this.reviewCount,
    required this.url,
    required this.ageCategory,
  });

  @override
  Widget build(BuildContext context) {
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
                imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 121, 85, 72),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    id.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 0, 0, 0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    date,
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
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  circle,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              getStarRating(rating),
              Text(
                rating.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text("($rateCount)",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 130, 130, 130),
                  )),
              Icon(
                Icons.message,
                size: 16,
                color: const Color.fromARGB(153, 255, 255, 255),
              ),
              Text(
                "($reviewCount)",
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 130, 130, 130)),
              ),
              Icon(
                CupertinoIcons.clock_solid,
                size: 16,
                color: const Color.fromARGB(180, 255, 255, 255),
              ),
              Text(
                calcDuration(duration),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.open_in_new,
                  size: 16, color: const Color.fromARGB(180, 255, 255, 255)),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(url));
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
          Row(
            children: [
              SizedBox(width: 8),
              Text(
                "$price JPY",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(width: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "銷量: $selled",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 76, 175, 80),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  getAgeString(ageCategory),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 76, 175, 80),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          // 標籤區塊
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: tags
                  .map((tag) => TagWidget(
                        tag: tag,
                      ))
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
              children: cvs
                  .map((cv) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 150, 136),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          cv,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// 小標籤 Widget
class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

String calcDuration(int duration) {
  int hr = duration ~/ 3600;
  if (hr > 0) {
    return "(${(duration / 3600).toStringAsFixed(1)})hr";
  }
  int min = (duration % 3600) ~/ 60;
  if (min > 0) {
    return "(${min}min)";
  }
  return "(${duration}s)";
}

dynamic getStarRating(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      if (index < rating) {
        if (rating - index >= 1) {
          return Icon(Icons.star, size: 22, color: Colors.amber);
        } else {
          return Icon(Icons.star_half, size: 22, color: Colors.amber);
        }
      } else {
        return Icon(Icons.star_border, size: 22, color: Colors.amber);
      }
    }),
  );
}

String getAgeString(String ageCategory) {
  switch (ageCategory) {
    case "general":
      return "全年齡";
    default:
      return "";
  }
}
