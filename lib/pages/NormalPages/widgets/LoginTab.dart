// flutter
import 'package:flutter/material.dart';

// page
import 'package:kikoeru/pages/NormalPages/pages/LoginPage.dart';

Widget loginTab(BuildContext context) {
  return ListTile(
    title: const Text("Login"),
    trailing: const Icon(Icons.login_sharp),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
          fullscreenDialog: true,
        ),
      );
    },
  );
}
