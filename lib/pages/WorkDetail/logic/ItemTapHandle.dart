// flutter
import 'dart:io';
import 'package:flutter/material.dart';

// 3rd lib
import 'package:http/http.dart' as http;
import 'package:kikoeru/core/utils/httpBase.dart';

// api
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin ItemTap {
  Future<String> _fetchContent(String url) async {
    try {
      return await sendRequest(url);
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  Widget _openText(String title, String url) {
    return FutureBuilder<String>(
      future: _fetchContent(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text("Error Occurs"));
        } else {
          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(child: Text(snapshot.data!)),
            ),
          );
        }
      },
    );
  }

  Widget _openImage(BuildContext context, String title, String url) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          child: Image.network(url),
          onLongPress: () async {
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
          },
        ),
      ),
    );
  }

  Widget _openPdf(String title, String url) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfPdfViewer.network(url, enableDoubleTapZooming: true),
      ),
    );
  }

  void handleItemTap(BuildContext context, Map<String, dynamic> item) {
    switch (item["type"]) {
      case "text":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _openText(
              item["title"],
              item["mediaDownloadUrl"],
            ),
          ),
        );
        break;
      case "image":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _openImage(
              context,
              item["title"],
              item["mediaStreamUrl"],
            ),
          ),
        );
        break;
      case "other":
        if (item["title"].endsWith(".pdf")) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _openPdf(
                item["title"],
                item["mediaStreamUrl"],
              ),
            ),
          );
        }
        break;
    }
  }
}
