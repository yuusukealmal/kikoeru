class LanguageEditionsClass {
  LanguageEditionsClass({required this.languageDitionsDetail}) {
    lang = languageDitionsDetail["lang"] ?? "";
    lable = languageDitionsDetail["lable"] ?? "";
    workno = languageDitionsDetail["workno"] ?? "";
    editionID = languageDitionsDetail["edition_id"] ?? 0;
    editionType = languageDitionsDetail["edition_type"] ?? "";
    displayOrder = languageDitionsDetail["display_order"] ?? 0;
  }

  final Map<String, dynamic> languageDitionsDetail;
  late final String lang;
  late final String lable;
  late final String workno;
  late final int editionID;
  late final String editionType;
  late final int displayOrder;
}
