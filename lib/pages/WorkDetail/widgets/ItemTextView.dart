// flutter
import "package:flutter/material.dart";

// frb
import "package:kikoeru/src/rust/api/requests/interface.dart";

Widget ItemTextView(String title, String url) {
  return FutureBuilder<String>(
    future: textFetch(url: url),
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
