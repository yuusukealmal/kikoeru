// flutter
import 'package:flutter/widgets.dart';

// 3rd lib
import 'package:http/http.dart' as http;

Future<String> sendRequest(
  String url, {
  Map<String, String>? headers,
  String? body,
}) async {
  headers = headers ??
      {
        "Content-Type": "application/json",
        "User-Agent":
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)'
      };

  debugPrint(
      "requests URL: $url\nrequests headers: $headers\nrequests body: $body");

  http.Response response = await (body != null
      ? http.post(Uri.parse(url), headers: headers, body: body)
      : http.get(Uri.parse(url), headers: headers));
  return response.body;
}
