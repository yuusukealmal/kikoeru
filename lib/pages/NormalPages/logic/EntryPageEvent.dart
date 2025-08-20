// flutter
import "package:flutter/material.dart";

// 3rd party
import "package:provider/provider.dart";

// config
import "package:kikoeru/core/config/provider/ThemeProvider.dart";

// pages
import "package:kikoeru/main.dart";

void toggleTheme(BuildContext context) async {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  await themeProvider.toggleTheme();
}

void handleTabSelection(TabController tabController) {
  const tabIndexMap = {0: "熱門作品", 1: "推薦作品", 2: "我的收藏", 3: "All 所有作品"};
  final currentPage = tabIndexMap[tabController.index];

  if (tabController.indexIsChanging) {
    logger.d("Tab is changing to: $currentPage");
  } else if (!tabController.indexIsChanging) {
    logger.d("Tab changed to: $currentPage");
  }
}
