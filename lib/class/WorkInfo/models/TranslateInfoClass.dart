class TranslateInfoClass {
  TranslateInfoClass({required this.translateInfoDetail}) {
    lang = translateInfoDetail["lang"] ?? "";
    isChild = translateInfoDetail["is_child"] ?? false;
    isParent = translateInfoDetail["is_parent"] ?? false;
    isOriginal = translateInfoDetail["is_original"] ?? false;
    isVolunteer = translateInfoDetail["is_volunteer"] ?? false;
    childWorknos = translateInfoDetail["child_worknos"] ?? [];
    parentWoerkno = translateInfoDetail["parent_woerkno"] ?? "";
    originalWorkno = translateInfoDetail["original_workno"] ?? "";
    isTranslationAgree = translateInfoDetail["is_translation_agree"] ?? false;
    translationBonusLangs =
        translateInfoDetail["translation_bonus_langs"] ?? [];
    isTranslationBonusParent =
        translateInfoDetail["is_translation_bonus_parent"] ?? false;
  }

  final Map<String, dynamic> translateInfoDetail;
  late final String lang;
  late final bool isChild;
  late final bool isParent;
  late final bool isOriginal;
  late final bool isVolunteer;
  late final List<dynamic> childWorknos;
  late final String parentWoerkno;
  late final String originalWorkno;
  late final bool isTranslationAgree;
  late final List<dynamic> translationBonusLangs;
  late final bool isTranslationBonusParent;
}
