import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Request {
  static final String _API = "https://api.asmr-200.com/api/";

  static Future<String> getALlWorks(int index, [int order = 1]) async {
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
        "${_API}works?order=${orders[order]}&sort=desc&page=$index&subtitle=0";
    if (order == 9) {
      int rand = Random().nextInt(100);
      URL =
          "https://api.asmr-200.com/api/works?order=random&sort=desc&page=$index&seed=$rand&subtitle=0";
    }

    http.Response response = await http.get(Uri.parse(URL));

    return response.body;
  }

  static Future<String> getPopularWorks(int index) async {
    String URL = "${_API}recommender/popular";
    Map<String, dynamic> data = {
      "keyword": " ",
      "page": index,
      "subtitle": 0,
      "localSubtitledWorks": [],
      "withPlaylistStatus": []
    };
    final response = await http.post(
      Uri.parse(URL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return response.body;
  }

  static Future<String> getWorkInfo([String id = "403038"]) async {
    String url = "https://api.asmr-200.com/api/tracks/$id?v=1";

    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
}
