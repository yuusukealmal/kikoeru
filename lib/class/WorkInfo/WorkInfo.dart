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
  WorkInfo({required this.work}) {
    id = work["id"] ?? 0;
    title = work["title"] ?? "";
    circleID = work["circle_id"] ?? 0;
    name = work["name"] ?? "";
    NFSW = work["nsfw"] ?? false;
    release = work["release"] ?? "";
    dlCount = work["dl_count"] ?? 0;
    price = work["price"] ?? 0;
    reviewCount = work["review_count"] ?? 0;
    rateCount = work["rate_count"] ?? 0;
    rateAverage2dp = (work["rate_average_2dp"]?.toDouble()) ?? 0.0;
    rateCountDetail = (work["rate_count_detail"] as List?)
            ?.map((e) => RatecountDetailClass(rateDetail: e))
            .toList() ??
        [];
    rank =
        (work["rank"] as List?)?.map((e) => RankClass(rankDetail: e)).toList();
    hasSubTitle = work["has_subtitle"] ?? false;
    createData = work["create_date"] ?? "";
    vas = (work["vas"] as List?)?.map((e) => VasClass(vasDetail: e)).toList() ??
        [];
    tags =
        (work["tags"] as List?)?.map((e) => TagClass(tagDetail: e)).toList() ??
            [];
    languageEditions = () {
      final langEditions = work["language_editions"];
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

      return editionsList
          .map((e) => LanguageEditionsClass(languageDitionsDetail: e))
          .toList();
    }();
    orginalWorkNo = work["original_workno"];
    otherLangEditionsInDB = (work["other_language_editions_in_db"] as List?)
            ?.map((e) => OtherlanginDBClass(otherlanginDBDetail: e))
            .toList() ??
        [];
    translateInfo =
        TranslateInfoClass(translateInfoDetail: work["translation_info"]);
    workAttributes = work["work_attributes"] ?? "";
    ageCategoryString = work["age_category_string"] ?? "";
    duration = work["duration"] ?? 0;
    sourceType = work["source_type"] ?? "";
    sourceID = work["source_id"] ?? "";
    sourceURL = work["source_url"] ?? "";
    userRating = work["userRating"];
    playlistStatus = work["playlistStatus"] as Map<String, dynamic>?;
    circle = CircleClass(circleDetail: work["circle"] ?? {});
    samCoverUrl = work["samCoverUrl"] ?? "";
    thumbnailCoverUrl = work["thumbnailCoverUrl"] ?? "";
    mainCoverUrl = work["mainCoverUrl"] ?? "";
  }

  final Map<String, dynamic> work;
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
