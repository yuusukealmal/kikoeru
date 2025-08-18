// flutter
import 'dart:math';
import 'dart:convert';

// config
import 'package:kikoeru/core/config/SharedPreferences.dart';

// api
import 'package:kikoeru/core/utils/httpBase.dart';

enum SearchType { STRING, VAS, Circle, Tag }

class Request {
  static const String _API = "https://api.asmr-200.com/api/";

  static const List<String> orders = [
    "release", //發售日期倒序
    "create_date", //最新收錄
    // "rating", // 我的評價倒序
    "dl_count", // 銷量倒序
    "price", // 價格倒序
    "rate_average_2dp", //評價倒序
    "review_count", // 評論數量倒序
    "id", //RJ號倒敘
    "nsfw", // 全年齡倒序
    "random" // 隨機
  ];

  static Future<String> getAllWorks({
    int index = 1,
    int subtitle = 0,
    int order = 1,
  }) async {
    String URL =
        "${_API}works?order=${orders[order]}&sort=desc&page=$index&subtitle=$subtitle";
    if (order == 9) {
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
    String URL =
        "${_API}search/%20${params.replaceAll(" ", "%20")}?order=${orders[order]}&sort=desc&page=$index&subtitle=$subtitle&includeTranslationWorks=true";
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
