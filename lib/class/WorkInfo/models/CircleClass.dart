class CircleClass {
  CircleClass({required this.circleDetail}) {
    id = circleDetail["id"] ?? 0;
    name = circleDetail["name"] ?? "";
    sourceID = circleDetail["source_id"] ?? "";
    srouceType = circleDetail["source_type"] ?? "";
  }

  final Map<String, dynamic> circleDetail;
  late final int id;
  late final String name;
  late final String sourceID;
  late final String srouceType;
}
