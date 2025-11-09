// flutter
import "package:flutter/material.dart";

// widget
import "package:kikoeru/pages/HomePage/widgets/HomePageWorkCard.dart";
import "package:kikoeru/pages/WorkDetail/widgets/WorkDetailCardView.dart";

// class
import "package:kikoeru/class/WorkInfo/models/RateCountDetailClass.dart";
import "package:kikoeru/class/WorkInfo/models/RankClass.dart";
import "package:kikoeru/class/WorkInfo/models/VasClass.dart";
import "package:kikoeru/class/WorkInfo/models/LanguageEditionsClass.dart";
import "package:kikoeru/class/WorkInfo/models/OtherLangInDBClass.dart";
import "package:kikoeru/class/WorkInfo/models/TagClass.dart";
import "package:kikoeru/class/WorkInfo/models/TranslateInfoClass.dart";
import "package:kikoeru/class/WorkInfo/models/CircleClass.dart";

class WorkInfo {
  WorkInfo.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? 0;
    title = map["title"] ?? "";
    circleID = map["circle_id"] ?? 0;
    name = map["name"] ?? "";
    NFSW = map["nsfw"] ?? false;
    release = map["release"] ?? "";
    dlCount = map["dl_count"] ?? 0;
    price = map["price"] ?? 0;
    reviewCount = map["review_count"] ?? 0;
    rateCount = map["rate_count"] ?? 0;
    rateAverage2dp = (map["rate_average_2dp"]?.toDouble()) ?? 0.0;
    rateCountDetail =
        (map["rate_count_detail"] as List?)
            ?.map((e) => RatecountDetailClass.fromMap(e))
            .toList() ??
        [];
    rank =
        (map["rank"] as List?)?.map((e) => RankClass.fromMap(e)).toList() ?? [];
    hasSubTitle = map["has_subtitle"] ?? false;
    createData = map["create_date"] ?? "";
    vas = (map["vas"] as List?)?.map((e) => VasClass.fromMap(e)).toList() ?? [];
    tags =
        (map["tags"] as List?)?.map((e) => TagClass.fromMap(e)).toList() ?? [];
    languageEditions = () {
      final langEditions = map["language_editions"];
      if (langEditions == null) return <LanguageEditionsClass>[];

      final List<Map<String, dynamic>> editionsList;
      if (langEditions is Map<String, dynamic>) {
        editionsList =
            langEditions.values.cast<Map<String, dynamic>>().toList();
      } else if (langEditions is List) {
        editionsList = langEditions.cast<Map<String, dynamic>>();
      } else {
        return <LanguageEditionsClass>[];
      }

      return editionsList.map((e) => LanguageEditionsClass.fromMap(e)).toList();
    }();
    orginalWorkNo = map["original_workno"];
    otherLangEditionsInDB =
        (map["other_language_editions_in_db"] as List?)
            ?.map((e) => OtherlanginDBClass.fromMap(e))
            .toList() ??
        [];
    translateInfo = TranslateInfoClass.fromMap(map["translation_info"]);
    workAttributes = map["work_attributes"] ?? "";
    ageCategoryString = map["age_category_string"] ?? "";
    duration = map["duration"] ?? 0;
    sourceType = map["source_type"] ?? "";
    sourceID = map["source_id"] ?? "";
    sourceURL = map["source_url"] ?? "";
    userRating = map["userRating"];
    playlistStatus = map["playlistStatus"] as Map<String, dynamic>?;
    circle = CircleClass.fromMap(map["circle"] ?? {});
    samCoverUrl = map["samCoverUrl"] ?? "";
    thumbnailCoverUrl = map["thumbnailCoverUrl"] ?? "";
    mainCoverUrl = map["mainCoverUrl"] ?? "";
  }

  late final int id;
  late final String title;
  late final int circleID;
  late final String name;
  late final bool NFSW;
  late final String release;
  late final int dlCount;
  late final int price;
  late final int reviewCount;
  late final int rateCount;
  late final double rateAverage2dp;
  late final List<RatecountDetailClass> rateCountDetail;
  late final List<RankClass>? rank;
  late final bool hasSubTitle;
  late final String createData;
  late final List<VasClass> vas;
  late final List<TagClass> tags;
  late final List<LanguageEditionsClass> languageEditions;
  late final String? orginalWorkNo;
  late final List<OtherlanginDBClass> otherLangEditionsInDB;
  late final TranslateInfoClass translateInfo;
  late final String workAttributes;
  late final String ageCategoryString;
  late final int duration;
  late final String sourceType;
  late final String sourceID;
  late final String sourceURL;
  late int? userRating;
  late final Map<String, dynamic>? playlistStatus;
  late final CircleClass circle;
  late final String samCoverUrl;
  late final String thumbnailCoverUrl;
  late final String mainCoverUrl;

  Widget HomePageWorkCard() {
    return HomePageWrokCard(work: this);
  }

  Widget DetailWorkCard() {
    return WorkDetailCardView(work: this);
  }
}
