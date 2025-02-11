import 'package:flutter/material.dart';
import 'package:kikoeru/config/SharedPreferences.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/pages/LoginPage.dart';
import 'package:kikoeru/widget/BaseWorkPage.dart';

class FavoriteWorkPage extends BaseWorkPage {
  FavoriteWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) =>
              Request.getFavoriteWorks(index: page),
        );

  @override
  State<FavoriteWorkPage> createState() => _RecommandWorkPageState();
}

class _RecommandWorkPageState extends BaseWorkPageState<FavoriteWorkPage> {
  @override
  bool checkLogin() {
    return SharedPreferencesHelper.getString("USER.RECOMMENDER.UUID") != null;
  }

  @override
  Widget build(BuildContext context) {
    if (!checkLogin()) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("請先登入"),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                setState(() {
                  if (checkLogin()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("成功登入")),
                    );
                    fetchCurrentPage();
                  }
                });
              },
              child: const Text("登入"),
            ),
          ],
        ),
      );
    }
    return super.build(context);
  }
}
