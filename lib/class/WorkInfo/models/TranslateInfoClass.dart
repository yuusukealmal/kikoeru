// class
import 'package:kikoeru/class/WorkInfo/models/TranslateBonusLangsClass.dart';

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
    translationBonusLangs = () {
      final translationBonusLangsDetail =
          translateInfoDetail['translation_bonus_langs'];
      if (translationBonusLangsDetail == null) {
        return <Translatebonuslangsclass>[];
      }
      final List<Map<String, dynamic>> translateBonusLangsList;
      if (translationBonusLangsDetail is Map<String, dynamic>) {
        translateBonusLangsList = translationBonusLangsDetail.values
            .cast<Map<String, dynamic>>()
            .toList();
      } else if (translationBonusLangsDetail is List) {
        translateBonusLangsList =
            translationBonusLangsDetail.cast<Map<String, dynamic>>();
      } else {
        return <Translatebonuslangsclass>[];
      }
      return translateBonusLangsList
          .map((e) => Translatebonuslangsclass(translateBonusLangsDetail: e))
          .toList();
    }();
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
  late final List<Translatebonuslangsclass> translationBonusLangs;
  late final bool isTranslationBonusParent;
}
