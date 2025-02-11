import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kikoeru/config/SharedPreferences.dart';

class Request {
  static final String _API = "https://api.asmr-200.com/api/";
  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "User-Agent":
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)'
  };
  static List<String> orders = [
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

  static Future<String> _sendRequest(String url,
      {Map<String, String>? headers, String? body}) async {
    http.Response response = await (body != null
        ? http.post(Uri.parse(url), headers: headers, body: body)
        : http.get(Uri.parse(url), headers: headers));
    return response.body;
  }

  static Future<String> getAllWorks(
      {int index = 1, int subtitle = 0, int order = 1}) async {
    String URL =
        "${_API}works?order=${orders[order]}&sort=desc&page=$index&subtitle=$subtitle";
    if (order == 9) {
      int rand = Random().nextInt(100);
      URL =
          "${_API}works?order=random&sort=desc&page=$index&seed=$rand&subtitle=0";
    }

    return await _sendRequest(URL);
  }

  static Future<String> getPopularWorks(
      {int index = 1, int subtitle = 0}) async {
    String URL = "${_API}recommender/popular";
    Map<String, dynamic> data = {
      "keyword": " ",
      "page": index,
      "subtitle": subtitle,
      "localSubtitledWorks": [],
      "withPlaylistStatus": []
    };
    return await _sendRequest(URL, headers: _headers, body: jsonEncode(data));
  }

  static Future<String> getRecommendedWorks(
      {int index = 1, int subtitle = 0}) async {
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
    return await _sendRequest(URL, headers: _headers, body: jsonEncode(data));
  }

  static Future<String> getFavoriteWorks({int index = 1}) async {
    String URL = "${_API}review?order=updated_at&sort=desc&page=$index";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer ${SharedPreferencesHelper.getString("USER.TOKEN")}"
    };
    return await _sendRequest(URL, headers: headers);
  }

  static Future<String> getSearchWorks(
      {String querys = " ",
      int index = 1,
      int subtitle = 0,
      int order = 1}) async {
    String URL =
        "${_API}search/%20${querys.replaceAll(" ", "%20")}?order=${orders[order]}&sort=desc&page=$index&subtitle=$subtitle&includeTranslationWorks=true";
    return await _sendRequest(URL);
  }

  static Future<String> getWorkInfo({String id = "403038"}) async {
    String url = "${_API}tracks/$id?v=1";
    return await _sendRequest(url);
  }

  static Future<bool> tryFetchToken(
      {required String account, required String password}) async {
    Map<String, String> accountInfo = {"name": account, "password": password};
    String url = "https://api.asmr.one/api/auth/me";

    final response = await _sendRequest(url,
        headers: _headers, body: jsonEncode(accountInfo));
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
