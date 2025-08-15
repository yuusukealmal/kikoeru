// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Widget ItemPdfView(String title, String url) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfPdfViewer.network(url, enableDoubleTapZooming: true),
    ),
  );
}
