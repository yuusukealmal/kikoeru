// 3rd lib
import "package:http/http.dart" as http;

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// pages
import "package:kikoeru/main.dart";

class HttpBase {
  static const Map<String, dynamic> templateHeaders = {
    "Content-Type": "application/json",
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)",
  };

  static Future<String> get(
    Uri url, {
    Map<String, String>? headers,
    bool? tokenRequired,
  }) async {
    headers = headers ?? {...templateHeaders, ...?headers};

    if (tokenRequired == true &&
        SharedPreferencesHelper.getString('USER.TOKEN') != null) {
      headers["Authorization"] =
          "Bearer ${SharedPreferencesHelper.getString('USER.TOKEN')}";
    }

    logger.d(
      "requests URL: $url\nrequests headers: $headers",
    );

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode < 200 || response.statusCode > 299) {
      logger.e("HTTP Error: ${response.statusCode}\nMessage: ${response.body}");

      // throw Exception(
      //   "HTTP Error: ${response.statusCode}\nMessage: ${response.body}",
      // );
    }

    return response.body;
  }

  static Future<String> post(
    Uri url, {
    Map<String, String>? headers,
    String? body,
    bool? tokenRequired,
  }) async {
    headers = headers ?? {...templateHeaders, ...?headers};

    if (tokenRequired == true &&
        SharedPreferencesHelper.getString('USER.TOKEN') != null) {
      headers["Authorization"] =
          "Bearer ${SharedPreferencesHelper.getString('USER.TOKEN')}";
    }

    logger.d(
      "requests URL: $url\nrequests headers: $headers\nrequests body: $body",
    );

    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode < 200 || response.statusCode > 299) {
      logger.e("HTTP Error: ${response.statusCode}\nMessage: ${response.body}");

      // throw Exception(
      //   "HTTP Error: ${response.statusCode}\nMessage: ${response.body}",
      // );
    }

    return response.body;
  }

  static Future<String> put(
    Uri url, {
    Map<String, String>? headers,
    String? body,
    bool? tokenRequired,
  }) async {
    headers = headers ?? {...templateHeaders, ...?headers};

    if (tokenRequired == true &&
        SharedPreferencesHelper.getString('USER.TOKEN') != null) {
      headers["Authorization"] =
          "Bearer ${SharedPreferencesHelper.getString('USER.TOKEN')}";
    }

    logger.d(
      "requests URL: $url\nrequests headers: $headers\nrequests body: $body",
    );

    http.Response response = await http.put(url, headers: headers, body: body);

    if (response.statusCode < 200 || response.statusCode > 299) {
      logger.e("HTTP Error: ${response.statusCode}\nMessage: ${response.body}");

      // throw Exception(
      //   "HTTP Error: ${response.statusCode}\nMessage: ${response.body}",
      // );
    }

    return response.body;
  }
}
