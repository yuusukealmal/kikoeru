// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// widget
import "package:kikoeru/pages/NormalPages/widgets/LogoutTab.dart";
import "package:kikoeru/pages/NormalPages/widgets/ResetShardTab.dart";

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(SharedPreferencesHelper.getString("USER.TOKEN") != null
                ? SharedPreferencesHelper.getString("USER.NAME") ?? "Not Login"
                : "Not Login"),
          ),
          resetShardTab(context),
          if (SharedPreferencesHelper.getString("USER.TOKEN") != null)
            logoutTab(context)
        ],
      ),
    );
  }
}
