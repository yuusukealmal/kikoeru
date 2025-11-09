class RatecountDetailClass {
  RatecountDetailClass.fromMap(Map<String, dynamic> map) {
    reviewCount = map["review_point"] ?? 0;
    count = map["count"] ?? 0;
    ratio = map["ratio"] ?? 0;
  }

  late final int reviewCount;
  late final int count;
  late final int ratio;
}
