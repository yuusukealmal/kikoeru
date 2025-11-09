class RankClass {
  RankClass.fromMap(Map<String, dynamic> map) {
    term = map["term"] ?? "";
    category = map["category"] ?? "";
    rank = map["rank"] ?? 0;
    rankDate = map["rank_date"] ?? "";
  }

  late final String term;
  late final String category;
  late final int rank;
  late final String rankDate;
}
