class RatecountDetailClass {
  RatecountDetailClass({required this.rateDetail}) {
    reviewCount = rateDetail["review_point"] ?? 0;
    count = rateDetail["count"] ?? 0;
    ratio = rateDetail["ratio"] ?? 0;
  }

  final Map<String, dynamic> rateDetail;
  late final int reviewCount;
  late final int count;
  late final int ratio;
}
