import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kikoeru/config/SharedPreferences.dart';

class Request {
  static final String _API = "https://api.asmr-200.com/api/";

  static Future<String> getALlWorks(int index, int subtitle,
      [int order = 1]) async {
    List<String> orders = [
      "release", //發售日期倒序
      "create_date", //最新收錄
      "rating", // 我的評價倒序
      "dl_count", // 銷量倒序
      "price", // 價格倒序
      "rate_average_2dp", //評價倒序
      "review_count", // 評論數量倒序
      "id", //RJ號倒敘
      "nsfw", // 全年齡倒序
      "random" // 隨機
    ];
    String URL =
        "${_API}works?order=${orders[order]}&sort=desc&page=$index&subtitle=$subtitle";
    if (order == 9) {
      int rand = Random().nextInt(100);
      URL =
          "https://api.asmr-200.com/api/works?order=random&sort=desc&page=$index&seed=$rand&subtitle=0";
    }

    http.Response response = await http.get(Uri.parse(URL));

    return response.body;
  }

  static Future<String> getPopularWorks(int index, int subtitle) async {
    String URL = "${_API}recommender/popular";
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, dynamic> data = {
      "keyword": " ",
      "page": index,
      "subtitle": subtitle,
      "localSubtitledWorks": [],
      "withPlaylistStatus": []
    };

    http.Response response = await http.post(
      Uri.parse(URL),
      headers: headers,
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String> getRecommandWorks(int index, int subtitle) async {
    String URL = "${_API}recommender/recommend-for-user";
    Map<String, String> headers = {
      "Referer": 'https://www.asmr.one/',
      "Content-Type": "application/json",
      "User-Agent":
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)'
    };
    Map<String, dynamic> data = {
      "keyword": " ",
      "recommenderUuid":
          SharedPreferencesHelper.getString("USER.RECOMMENDER.UUID"),
      "page": index,
      "subtitle": subtitle,
      "localSubtitledWorks": [],
      "withPlaylistStatus": []
    };
    final response = await http.post(
      Uri.parse(URL),
      headers: headers,
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String> getWorkInfo([String id = "403038"]) async {
    String url = "https://api.asmr-200.com/api/tracks/$id?v=1";

    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  static Future<bool> tryFetchToken(String account, String password) async {
    Map<String, String> accountInfo = {"name": account, "password": password};
    Map<String, String> headers = {
      "Referer": 'https://www.asmr.one/',
      "User-Agent":
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)',
      "Content-Type": "application/json"
    };
    http.Response response = await http.post(
      Uri.parse("https://api.asmr.one/api/auth/me"),
      headers: headers,
      body: jsonEncode(accountInfo),
    );

    dynamic jsonres = jsonDecode(response.body);
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
