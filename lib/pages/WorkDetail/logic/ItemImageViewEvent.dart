// flutter
import 'dart:io';
import 'package:flutter/material.dart';

// 3rd lib
import 'package:http/http.dart' as http;

void handleDoubleTap(
    TransformationController controller, double zoom, TapDownDetails? details) {
  if (details == null) return;

  if (controller.value != Matrix4.identity()) {
    controller.value = Matrix4.identity();
  } else {
    final x = -details.localPosition.dx * (zoom - 1);
    final y = -details.localPosition.dy * (zoom - 1);
    controller.value = Matrix4.identity()
      ..translate(x, y)
      ..scale(zoom);
  }
}

void handleLongPress(BuildContext context, String title, String url) async {
  Directory directory = Directory('/storage/emulated/0/Download');
  File f = File("${directory.path}/$title.jpg");
  await f.writeAsBytes(
    await http.get(Uri.parse(url)).then(
      (response) {
        return response.bodyBytes;
      },
    ),
  );
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("已下載到${f.path}")));
}
