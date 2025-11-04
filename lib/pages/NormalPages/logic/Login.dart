// flutter
import "dart:convert";
import "package:flutter/material.dart";

// frb
import "package:kikoeru/src/rust/api/requests/interface.dart";
import "package:kikoeru/src/rust/api/requests/config/types.dart";

// class
import "package:kikoeru/class/Playlist/Playlist.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";
import "package:kikoeru/core/utils/Auth.dart";

// pages
import "package:kikoeru/pages/NormalPages/pages/EntryPage.dart";

Future<void> login(
  BuildContext context,
  String account,
  String password,
) async {
  if (account.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("請輸入帳號和密碼")));
    return;
  } else {
    try {
      Env env = await tryFetchToken(account: account, password: password);

      await SharedPreferencesHelper.setString("USER.NAME", account);
      await SharedPreferencesHelper.setString("USER.PASSWORD", password);
      await SharedPreferencesHelper.setString(
        "USER.RECOMMENDER.UUID",
        env.recommenderUuid,
      );
      await SharedPreferencesHelper.setString("USER.TOKEN", env.token);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }

    try {
      String playlist = await getPlayList(authHeader: getAuthHeader());

      final Playlist playlistInfo = Playlist(
        playlistDetail: jsonDecode(playlist),
      );
      SharedPreferencesHelper.setString("USER.PLAYLIST", playlistInfo.id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EntryPage(title: "Kikoeru")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }
  }
}
