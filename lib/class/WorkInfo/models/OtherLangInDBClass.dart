class OtherlanginDBClass {
  OtherlanginDBClass({required this.otherlanginDBDetail}) {
    ID = otherlanginDBDetail["id"] ?? 0;
    lang = otherlanginDBDetail["lang"] ?? "";
    title = otherlanginDBDetail["title"] ?? "";
    sourceID = otherlanginDBDetail["source_id"] ?? "";
    isOriginal = otherlanginDBDetail["is_original"];
    sourceType = otherlanginDBDetail["source_type"] ?? "";
  }

  final Map<String, dynamic> otherlanginDBDetail;
  late final int ID;
  late final String lang;
  late final String title;
  late final String sourceID;
  late final bool isOriginal;
  late final String sourceType;
}
