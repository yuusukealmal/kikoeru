// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';

// config
import 'package:kikoeru/config/provider/AudioProvider.dart';
import 'package:kikoeru/config/provider/ThemeProvider.dart';
import 'package:kikoeru/config/SharedPreferences.dart';

// page
import 'package:kikoeru/pages/NormalPages/EntryPage.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const EntryPage(title: 'Kikoeru'),
    );
  }
}
