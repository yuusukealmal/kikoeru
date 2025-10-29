// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// widget
import "package:kikoeru/pages/NormalPages/widgets/ResetShardTab.dart";
import "package:kikoeru/pages/NormalPages/widgets/LogoutTab.dart";
import "package:kikoeru/pages/NormalPages/widgets/LoginTab.dart";

class DrawerWidget extends StatefulWidget {
  const DrawerWidget(
      {super.key, required this.selectedPageIndex, required this.setPage});

  final int selectedPageIndex;
  final Function(int) setPage;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final List<Map<String, dynamic>> _menuItems = [
    {'title': '🔥熱門作品', 'icon': Icons.whatshot},
    {'title': '🌟 推薦作品', 'icon': Icons.star},
    {'title': '❤ 我的收藏', 'icon': Icons.favorite},
    {'title': 'All works', 'icon': Icons.library_music},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              SharedPreferencesHelper.getString("USER.TOKEN") != null
                  ? SharedPreferencesHelper.getString("USER.NAME") ??
                      "Not Login"
                  : "Not Login",
              style: TextStyle(fontSize: 24),
            ),
          ),
          ..._menuItems.map((item) {
            int index = _menuItems.indexOf(item);

            return ListTile(
              leading: Icon(item['icon']),
              title: Text(item['title']),
              selected: widget.selectedPageIndex == index,
              onTap: () => widget.setPage(index),
            );
          }),
          const Divider(),
          resetShardTab(context),
          SharedPreferencesHelper.getString("USER.TOKEN") != null
              ? logoutTab(context)
              : loginTab(context),
        ],
      ),
    );
  }
}
