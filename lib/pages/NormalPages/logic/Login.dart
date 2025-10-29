// flutter
import "dart:convert";
import "package:flutter/material.dart";

// api
import "package:kikoeru/api/WorkRequest/httpRequests.dart";

// class
import "package:kikoeru/class/Playlist/Playlist.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// pages
import "package:kikoeru/pages/NormalPages/pages/EntryPage.dart";

Future<void> login(
  BuildContext context,
  String account,
  String password,
) async {
  if (account.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("請輸入帳號和密碼")),
    );
    return;
  } else {
    bool success =
        await Request.tryFetchToken(account: account, password: password);
    if (success) {
      String playlist = await Request.getPlaylist();

      final Playlist playlistInfo =
          Playlist(playlistDetail: jsonDecode(playlist));
      SharedPreferencesHelper.setString("USER.PLAYLIST", playlistInfo.id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EntryPage(title: "Kikoeru")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("帳號或是密碼有誤")),
      );
    }
  }
}
