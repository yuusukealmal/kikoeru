class CircleClass {
  CircleClass.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? 0;
    name = map["name"] ?? "";
    sourceID = map["source_id"] ?? "";
    srouceType = map["source_type"] ?? "";
  }

  late final int id;
  late final String name;
  late final String sourceID;
  late final String srouceType;
}
