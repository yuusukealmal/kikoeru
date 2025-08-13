// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';
import 'package:logger/web.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';
import 'package:kikoeru/core/config/provider/ThemeProvider.dart';
import 'package:kikoeru/core/config/SharedPreferences.dart';

// page
import 'package:kikoeru/pages/NormalPages/pages/EntryPage.dart';

final logger = Logger();
final routeObserver = RouteObserver<ModalRoute<void>>();

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
      navigatorObservers: [routeObserver],
      home: const EntryPage(title: 'Kikoeru'),
    );
  }
}
