// flutter
import "package:flutter/material.dart";

// api
import "package:kikoeru/api/WorkRequest/httpRequests.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// pages
import "package:kikoeru/pages/NormalPages/pages/LoginPage.dart";
import "package:kikoeru/pages/HomePage/pages/BaseWorkPage.dart";

// PopularWorks
class PopularWorkPage extends BasePage {
  PopularWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getPopularWorks(
            index: page,
            subtitle: hasLanguage ? 1 : 0,
          ),
        );

  @override
  State<PopularWorkPage> createState() => _PopularWorkPageState();
}

class _PopularWorkPageState extends BasePageState<PopularWorkPage> {}

// RecommendedWorks
class RecommandWorkPage extends BasePage {
  RecommandWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getRecommendedWorks(
            index: page,
            subtitle: hasLanguage ? 1 : 0,
          ),
        );

  @override
  State<RecommandWorkPage> createState() => _RecommandWorkPageState();
}

class _RecommandWorkPageState extends BasePageState<RecommandWorkPage> {
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
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                    fullscreenDialog: true,
                  ),
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
class FavoriteWorkPage extends BasePage {
  FavoriteWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) =>
              Request.getFavoriteWorks(index: page),
        );

  @override
  State<FavoriteWorkPage> createState() => _FavoriteWorkPageState();
}

class _FavoriteWorkPageState extends BasePageState<FavoriteWorkPage> {
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
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                    fullscreenDialog: true,
                  ),
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
class AllWorksPage extends BasePage {
  AllWorksPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getAllWorks(
            index: page,
            subtitle: hasLanguage ? 1 : 0,
            order: order,
          ),
        );

  @override
  State<AllWorksPage> createState() => _AllWorksPageState();
}

class _AllWorksPageState extends BasePageState<AllWorksPage> {}
