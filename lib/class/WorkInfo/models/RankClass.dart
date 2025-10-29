class RankClass {
  RankClass({required this.rankDetail}) {
    term = rankDetail["term"] ?? "";
    category = rankDetail["category"] ?? "";
    rank = rankDetail["rank"] ?? 0;
    rankDate = rankDetail["rank_date"] ?? "";
  }

  final Map<String, dynamic> rankDetail;
  late final String term;
  late final String category;
  late final int rank;
  late final String rankDate;
}
