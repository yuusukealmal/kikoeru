// 3rd lib
import 'package:http/http.dart' as http;

// pages
import 'package:kikoeru/main.dart';

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

  logger.d(
    "requests URL: $url\nrequests headers: $headers\nrequests body: $body",
  );

  http.Response response = await (body != null
      ? http.post(Uri.parse(url), headers: headers, body: body)
      : http.get(Uri.parse(url), headers: headers));

  if (response.statusCode < 200 || response.statusCode > 299) {
    logger.e('HTTP Error: ${response.statusCode}\nMessage: ${response.body}');

    throw Exception(
      'HTTP Error: ${response.statusCode}\nMessage: ${response.body}',
    );
  }

  return response.body;
}
