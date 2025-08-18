class OtherlangindbClass {
  OtherlangindbClass({required this.otherlangindbDetail}) {
    ID = otherlangindbDetail["id"] ?? 0;
    lang = otherlangindbDetail["lang"] ?? "";
    title = otherlangindbDetail["title"] ?? "";
    sourceID = otherlangindbDetail["source_id"] ?? "";
    isOriginal = otherlangindbDetail["is_original"];
    sourceType = otherlangindbDetail["source_type"] ?? "";
  }

  final Map<String, dynamic> otherlangindbDetail;
  late final int ID;
  late final String lang;
  late final String title;
  late final String sourceID;
  late final bool isOriginal;
  late final String sourceType;
}
