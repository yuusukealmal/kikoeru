import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

mixin openWorkContent {
  Widget openText(String title, String url) {
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

  Widget openImage(BuildContext context, String title, String url) {
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

  Widget openPdf(String title, String url) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfPdfViewer.network(url, enableDoubleTapZooming: true),
      ),
    );
  }

  Future<String> _fetchContent(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error: Unable to fetch text.";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
