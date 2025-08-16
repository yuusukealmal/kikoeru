// flutter
import 'package:flutter/material.dart';

// 3rd lib
import 'package:provider/provider.dart';
import 'package:logger/web.dart';
import 'package:audio_service/audio_service.dart';

// config
import 'package:kikoeru/core/config/provider/AudioProvider.dart';
import 'package:kikoeru/core/config/provider/ThemeProvider.dart';
import 'package:kikoeru/core/config/SharedPreferences.dart';
import 'package:kikoeru/core/utils/AudioHandler.dart';

// page
import 'package:kikoeru/pages/NormalPages/pages/EntryPage.dart';

final logger = Logger();
final routeObserver = RouteObserver<ModalRoute<void>>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();

  final audioProvider = AudioProvider();

  await AudioService.init(
    builder: () => MyAudioHandler(audioProvider),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.example.audio',
      androidNotificationChannelName: '音樂播放',
      androidNotificationOngoing: true,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: audioProvider),
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
