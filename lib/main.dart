import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/config/AudioProvider.dart';
import 'package:kikoeru/config/ThemeProvider.dart';
import 'package:kikoeru/config/SharedPreferences.dart';
import 'package:kikoeru/pages/EntryPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
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
      home: const EntryPage(title: 'Kikoeru'),
    );
  }
}
