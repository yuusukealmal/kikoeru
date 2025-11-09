// class
import "package:kikoeru/class/WorkInfo/models/TranslateBonusLangsClass.dart";

class TranslateInfoClass {
  TranslateInfoClass.fromMap(Map<String, dynamic> map) {
    lang = map["lang"];
    isChild = map["is_child"] ?? false;
    isParent = map["is_parent"] ?? false;
    isOriginal = map["is_original"] ?? false;
    isVolunteer = map["is_volunteer"] ?? false;
    childWorknos = map["child_worknos"] ?? [];
    parentWoerkno = map["parent_woerkno"];
    originalWorkno = map["original_workno"];
    isTranslationAgree = map["is_translation_agree"] ?? false;
    translationBonusLangs = () {
      final translationBonusLangsDetail = map["translation_bonus_langs"];
      if (translationBonusLangsDetail == null) {
        return <TranslatebonuslangsClass>[];
      }
      final List<Map<String, dynamic>> translateBonusLangsList;
      if (translationBonusLangsDetail is Map<String, dynamic>) {
        translateBonusLangsList =
            translationBonusLangsDetail.values
                .cast<Map<String, dynamic>>()
                .toList();
      } else if (translationBonusLangsDetail is List) {
        translateBonusLangsList =
            translationBonusLangsDetail.cast<Map<String, dynamic>>();
      } else {
        return <TranslatebonuslangsClass>[];
      }
      return translateBonusLangsList
          .map((e) => TranslatebonuslangsClass.fromMap(e))
          .toList();
    }();
    isTranslationBonusParent = map["is_translation_bonus_parent"] ?? false;
  }

  late final String? lang;
  late final bool isChild;
  late final bool isParent;
  late final bool isOriginal;
  late final bool isVolunteer;
  late final List<dynamic> childWorknos;
  late final String? parentWoerkno;
  late final String? originalWorkno;
  late final bool isTranslationAgree;
  late final List<TranslatebonuslangsClass> translationBonusLangs;
  late final bool isTranslationBonusParent;
}
