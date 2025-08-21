// flutter
import "package:flutter/material.dart";

// api
import "package:kikoeru/core/utils/httpBase.dart";

Widget ItemTextView(String title, String url) {
  return FutureBuilder<String>(
    future: HttpBase.get(Uri.parse(url)),
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
