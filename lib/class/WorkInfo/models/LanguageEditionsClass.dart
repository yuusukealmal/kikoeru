class LanguageEditionsClass {
  LanguageEditionsClass.fromMap(Map<String, dynamic> map) {
    lang = map["lang"] ?? "";
    lable = map["lable"] ?? "";
    workno = map["workno"] ?? "";
    editionID = map["edition_id"] ?? 0;
    editionType = map["edition_type"] ?? "";
    displayOrder = map["display_order"] ?? 0;
  }

  late final String lang;
  late final String lable;
  late final String workno;
  late final int editionID;
  late final String editionType;
  late final int displayOrder;
}
