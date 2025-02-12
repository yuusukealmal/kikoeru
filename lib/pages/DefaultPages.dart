import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/config/SharedPreferences.dart';
import 'package:kikoeru/pages/LoginPage.dart';
import 'package:kikoeru/widget/BaseWorkPage.dart';

// PopularWorks
class PopularWorkPage extends BaseWorkPage {
  PopularWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getPopularWorks(
              index: page, subtitle: hasLanguage ? 1 : 0),
        );

  @override
  State<PopularWorkPage> createState() => _PopularWorkPageState();
}

class _PopularWorkPageState extends BaseWorkPageState<PopularWorkPage> {}

// RecommendedWorks
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

// MyFavoriteWorks
class FavoriteWorkPage extends BaseWorkPage {
  FavoriteWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) =>
              Request.getFavoriteWorks(index: page),
        );

  @override
  State<FavoriteWorkPage> createState() => _FavoriteWorkPageState();
}

class _FavoriteWorkPageState extends BaseWorkPageState<FavoriteWorkPage> {
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

// AllWorks
class AllWorksPage extends BaseWorkPage {
  AllWorksPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getAllWorks(
              index: page, subtitle: hasLanguage ? 1 : 0, order: order),
        );

  @override
  State<AllWorksPage> createState() => _AllWorksPageState();
}

class _AllWorksPageState extends BaseWorkPageState<AllWorksPage> {}
