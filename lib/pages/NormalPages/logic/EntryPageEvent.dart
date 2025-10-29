// flutter
import "package:flutter/material.dart";

// 3rd party
import "package:provider/provider.dart";

// config
import "package:kikoeru/core/config/provider/ThemeProvider.dart";

void toggleTheme(BuildContext context) async {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  await themeProvider.toggleTheme();
}
