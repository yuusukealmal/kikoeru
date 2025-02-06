import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/behavior/theme.dart';
import 'package:kikoeru/behavior/SharedPreferences.dart';
import 'package:kikoeru/pages/MyHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const MyHomePage(title: 'Kikoeru'),
    );
  }
}
