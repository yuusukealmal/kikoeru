// flutter
import "dart:math";
import "dart:convert";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// api
import "package:kikoeru/core/utils/httpBase.dart";

enum SearchType { STRING, VAS, Circle, Tag }

enum SortType {
  ASC("asc"),
  DESC("desc");

  final String value;
  const SortType(this.value);
}

class Request {
  static const String _API = "https://api.asmr-200.com/api/";

  static const List<(String, SortType)> orders = [
    ("release", SortType.DESC), // "發售日期倒序"
    ("create_date", SortType.DESC), // "最新收錄"
    // ("rating", SortType.DESC), // "我的評價倒序"
    ("release", SortType.ASC), // "發售日期順序"
    ("dl_count", SortType.DESC), // "銷量倒序"
    ("price", SortType.ASC), // "價格順序"
    ("price", SortType.DESC), // "價格倒序"
    ("rate_average_2dp", SortType.DESC), // "評價倒序"
    ("review_count", SortType.DESC), // "評論數量倒序"
    ("id", SortType.DESC), // "RJ號倒序"
    ("id", SortType.ASC), // "RJ號順序"
    ("nsfw", SortType.ASC), // "全年齡順序"
    ("random", SortType.DESC) // "隨機"
  ];

  static Future<String> getAllWorks({
    int index = 1,
    int subtitle = 0,
    int order = 1,
  }) async {
    String orderKey = orders[order].$1;
    SortType sortType = orders[order].$2;

    String URL =
        "${_API}works?order=$orderKey&sort=${sortType.value}&page=$index&subtitle=$subtitle";
    if (order == orders.length - 1) {
      int rand = Random().nextInt(100);
      URL =
          "${_API}works?order=random&sort=desc&page=$index&seed=$rand&subtitle=0";
    }

    return await sendRequest(URL);
  }

  static Future<String> getPopularWorks({
    int index = 1,
    int subtitle = 0,
  }) async {
    String URL = "${_API}recommender/popular";
    Map<String, dynamic> data = {
      "keyword": " ",
      "page": index,
      "subtitle": subtitle,
      "localSubtitledWorks": [],
      "withPlaylistStatus": []
    };
    return await sendRequest(URL, body: jsonEncode(data));
  }

  static Future<String> getRecommendedWorks({
    int index = 1,
    int subtitle = 0,
  }) async {
    String URL = "${_API}recommender/recommend-for-user";
    Map<String, dynamic> data = {
      "keyword": " ",
      "recommenderUuid":
          SharedPreferencesHelper.getString("USER.RECOMMENDER.UUID"),
      "page": index,
      "subtitle": subtitle,
      "localSubtitledWorks": [],
      "withPlaylistStatus": []
    };
    return await sendRequest(URL, body: jsonEncode(data));
  }

  static Future<String> getFavoriteWorks({int index = 1}) async {
    String URL = "${_API}review?order=updated_at&sort=desc&page=$index";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer ${SharedPreferencesHelper.getString("USER.TOKEN")}"
    };
    return await sendRequest(URL, headers: headers);
  }

  static Future<String> getSearchWorks({
    required SearchType type,
    String querys = " ",
    int index = 1,
    int subtitle = 0,
    int order = 1,
  }) async {
    String params;
    switch (type) {
      case SearchType.STRING:
        params = querys;
      case SearchType.VAS:
        params = "\$va:$querys\$";
      case SearchType.Circle:
        params = "\$circle:$querys\$";
      case SearchType.Tag:
        params = "\$tag:$querys\$";
    }
    if (params.contains("/")) {
      params = Uri.encodeComponent(params);
    }
    String orderKey = orders[order].$1;
    SortType sortType = orders[order].$2;

    String URL =
        "${_API}search/%20${params.replaceAll(" ", "%20")}?order=$orderKey&sort=${sortType.value}&page=$index&subtitle=$subtitle&includeTranslationWorks=true";
    return await sendRequest(URL);
  }

  static Future<String> getWorkTrack({String id = "403038"}) async {
    String url = "${_API}tracks/$id?v=1";
    return await sendRequest(url);
  }

  static Future<bool> tryFetchToken({
    required String account,
    required String password,
  }) async {
    Map<String, String> accountInfo = {"name": account, "password": password};
    String url = "https://api.asmr.one/api/auth/me";

    final response = await sendRequest(url, body: jsonEncode(accountInfo));
    dynamic jsonres = jsonDecode(response);

    if (jsonres["user"]["loggedIn"]) {
      await SharedPreferencesHelper.setString("USER.NAME", account);
      await SharedPreferencesHelper.setString("USER.PASSWORD", password);
      await SharedPreferencesHelper.setString(
          "USER.RECOMMENDER.UUID", jsonres["user"]["recommenderUuid"]);
      await SharedPreferencesHelper.setString("USER.TOKEN", jsonres["token"]);
      return true;
    } else {
      return false;
    }
  }
}
