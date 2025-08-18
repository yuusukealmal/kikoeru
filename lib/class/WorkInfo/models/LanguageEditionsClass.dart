class LanguageeditionsClass {
  LanguageeditionsClass({required this.languageeDitionsDetail}) {
    lang = languageeDitionsDetail["lang"] ?? "";
    lable = languageeDitionsDetail["lable"] ?? "";
    workno = languageeDitionsDetail["workno"] ?? "";
    editionID = languageeDitionsDetail["edition_id"] ?? 0;
    editionType = languageeDitionsDetail["edition_type"] ?? "";
    displayOrder = languageeDitionsDetail["display_order"] ?? 0;
  }

  final Map<String, dynamic> languageeDitionsDetail;
  late final String lang;
  late final String lable;
  late final String workno;
  late final int editionID;
  late final String editionType;
  late final int displayOrder;
}
