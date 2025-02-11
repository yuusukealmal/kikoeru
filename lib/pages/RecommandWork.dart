import 'package:flutter/material.dart';
import 'package:kikoeru/config/SharedPreferences.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/widget/BaseWorkPage.dart';
import 'package:kikoeru/pages/LoginPage.dart';

class RecommandWorkPage extends BaseWorkPage {
  RecommandWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getRecommendedWorks(
              index: page, subtitle: hasLanguage ? 1 : 0),
        );

  @override
  State<RecommandWorkPage> createState() => _RecommandWorkPageState();
}

class _RecommandWorkPageState extends BaseWorkPageState<RecommandWorkPage> {
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
