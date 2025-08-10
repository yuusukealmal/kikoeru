// flutter
import 'package:flutter/material.dart';

// widget
import 'package:kikoeru/widget/HomePageWorkWidget/WorkCard.dart';

class Work {
  Work({required this.work}) {
    id = work['id'] ?? 0;
    title = work['title'] ?? 'Unknown';
    CircleID = work['circle_id'] ?? -1;
    name = work['name'] ?? 'Unknown';
    NFSW = work['nsfw'] ?? false;
    release = work['release'] ?? 'Unknown';
    dlCount = work['dl_count'] ?? 0;
    price = work['price'] ?? 0;
    ReviewCount = work['review_count'] ?? 0;
    RateCount = work['rate_count'] ?? 0;
    Rate = (work['rate_average_2dp'] ?? 0.0).toDouble();
    RateCountDetail = work['rate_count_detail'] ?? [];
    Rank = work['rank'] ?? [];
    HasSubTitle = work['has_subtitle'] ?? false;
    CreateData = work['create_date'] ?? 'Unknown';
    Vas = work['vas'] ?? [];
    Tags = work['tags'] ?? [];
    Lang = work['language_editions'] ?? [];
    OrginalWorkNo = work['original_workno'];
    OtherLang = work['other_language_editions_in_db'] ?? [];
    TranslateInfo = work['translation_info'];
    WorkAttr = work['work_attributes'] ?? 'Unknown';
    AgeCategory = work['age_category_string'] ?? 'Unknown';
    duration = work['duration'] ?? 0;
    source = work['source_type'] ?? 'Unknown';
    sourceID = work['source_id'] ?? 'Unknown';
    sourceURL = work['source_url'] ?? 'Unknown';
    Circle = work['circle'];
    samCoverUrl = work['samCoverUrl'] ?? '';
    thumbnailCoverUrl = work['thumbnailCoverUrl'] ?? '';
    mainCoverUrl = work['mainCoverUrl'] ?? '';
  }

  final Map<String, dynamic> work;
  late final int id;
  late final String title;
  late final int CircleID;
  late final String name;
  late final bool NFSW;
  late final String release;
  late final int dlCount;
  late final int price;
  late final int ReviewCount;
  late final int RateCount;
  late final double Rate;
  late final List<dynamic> RateCountDetail;
  late final List<dynamic> Rank;
  late final bool HasSubTitle;
  late final String CreateData;
  late final List<dynamic> Vas;
  late final List<dynamic> Tags;
  late final dynamic Lang;
  late final dynamic OrginalWorkNo;
  late final List<dynamic> OtherLang;
  late final Map<String, dynamic> TranslateInfo;
  late final String WorkAttr;
  late final String AgeCategory;
  late final int duration;
  late final String source;
  late final String sourceID;
  late final String sourceURL;
  late final dynamic Circle;
  late final String samCoverUrl;
  late final String thumbnailCoverUrl;
  late final String mainCoverUrl;

  Widget AllWorkCard() {
    return WrokCard(work: this);
  }
}
