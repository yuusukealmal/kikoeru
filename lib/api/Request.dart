import 'dart:math';

import 'package:http/http.dart' as http;

class Request {
  static final String _API = "https://api.asmr-200.com/api/";

  static Future<String> getALlWorks(int index, [int order = 1]) async {
    List<String> orders = [
      "release",
      "create_date",
      "rating",
      "dl_count",
      "price",
      "rate_average_2dp",
      "review_count",
      "id",
      "nsfw",
      "random"
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
}
