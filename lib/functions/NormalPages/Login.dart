// flutter
import 'package:flutter/material.dart';

// api
import 'package:kikoeru/api/WorkRequest/httpRequests.dart';

Future<void> login(
    BuildContext context, String account, String password) async {
  if (account.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("請輸入帳號和密碼")),
    );
    return;
  } else {
    bool success =
        await Request.tryFetchToken(account: account, password: password);
    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("帳號或是密碼有誤")),
      );
    }
  }
}
