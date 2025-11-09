class OtherlanginDBClass {
  OtherlanginDBClass.fromMap(Map<String, dynamic> map) {
    ID = map["id"] ?? 0;
    lang = map["lang"] ?? "";
    title = map["title"] ?? "";
    sourceID = map["source_id"] ?? "";
    isOriginal = map["is_original"] ?? false;
    sourceType = map["source_type"] ?? "";
  }

  late final int ID;
  late final String lang;
  late final String title;
  late final String sourceID;
  late final bool isOriginal;
  late final String sourceType;
}
