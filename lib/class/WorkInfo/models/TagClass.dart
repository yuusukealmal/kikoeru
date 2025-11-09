class HistoryItemClass {
  HistoryItemClass.fromMap(Map<String, dynamic> map) {
    name = map["name"] ?? "";
    deprecatedAt = map["deprecatedAt"] ?? 0;
  }

  late final String name;
  late final int deprecatedAt;
}

class LanguageContentClass {
  LanguageContentClass.fromMap(Map<String, dynamic> map) {
    name = map["name"] ?? "";
    history =
        map["history"] != null
            ? (map["history"] as List)
                .map((e) => HistoryItemClass.fromMap(e))
                .toList()
            : [];
    censored = map["censored"] ?? "";
  }

  late final String name;
  late final List<HistoryItemClass> history;
  late final String censored;
}

class i18nClass {
  i18nClass.fromMap(Map<String, dynamic> map) {
    enUs = LanguageContentClass.fromMap(map["en-us"]);
    jaJp = LanguageContentClass.fromMap(map["ja-jp"]);
    zhCn = LanguageContentClass.fromMap(map["zh-cn"]);
  }

  late final LanguageContentClass enUs;
  late final LanguageContentClass jaJp;
  late final LanguageContentClass zhCn;
}

class TagClass {
  TagClass.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? 0;
    i18n = i18nClass.fromMap(map["i18n"] ?? {});
    name = map["name"] ?? "";
    upvote = map["upvote"] ?? 0;
    downvote = map["downvote"] ?? 0;
    voteRank = map["voteRank"] ?? 0;
    voteStatus = map["voteStatus"] ?? 0;
  }

  late final int id;
  late final i18nClass i18n;
  late final String name;
  late final int upvote;
  late final int downvote;
  late final int voteRank;
  late final int voteStatus;
}
