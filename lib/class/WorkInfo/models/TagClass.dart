class HistoryItemClass {
  HistoryItemClass({required this.historyDetail}) {
    name = historyDetail["name"] ?? "";
    deprecatedAt = historyDetail["deprecatedAt"] ?? 0;
  }

  final Map<String, dynamic> historyDetail;
  late final String name;
  late final int deprecatedAt;
}

class LanguageContentClass {
  LanguageContentClass({required this.languageDetail}) {
    name = languageDetail["name"] ?? "";
    history = languageDetail["history"] != null
        ? (languageDetail["history"] as List)
            .map((e) => HistoryItemClass(historyDetail: e))
            .toList()
        : [];
    censored = languageDetail["censored"] ?? "";
  }

  final Map<String, dynamic> languageDetail;
  late final String name;
  late final List<HistoryItemClass> history;
  late final String censored;
}

class i18nClass {
  i18nClass({required this.i18nDetail}) {
    enUs = LanguageContentClass(languageDetail: i18nDetail["en-us"] ?? {});
    jaJp = LanguageContentClass(languageDetail: i18nDetail["ja-jp"] ?? {});
    zhCn = LanguageContentClass(languageDetail: i18nDetail["zh-cn"] ?? {});
  }

  final Map<String, dynamic> i18nDetail;
  late final LanguageContentClass enUs;
  late final LanguageContentClass jaJp;
  late final LanguageContentClass zhCn;
}

class TagClass {
  TagClass({required this.tagDetail}) {
    id = tagDetail["id"] ?? 0;
    i18n = i18nClass(i18nDetail: tagDetail["i18n"] ?? {});
    name = tagDetail["name"] ?? "";
    upvote = tagDetail["upvote"] ?? 0;
    downvote = tagDetail["downvote"] ?? 0;
    voteRank = tagDetail["voteRank"] ?? 0;
    voteStatus = tagDetail["voteStatus"] ?? 0;
  }

  final Map<String, dynamic> tagDetail;
  late final int id;
  late final i18nClass i18n;
  late final String name;
  late final int upvote;
  late final int downvote;
  late final int voteRank;
  late final int voteStatus;
}
