import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase_options.dart';
import 'package:paralat/Components/notifiche.dart';
import 'Components/auth.dart';
import 'screens/auth_page_2.dart';
import 'screens/HomePage.dart';

/// ✅ AdMob initializer con lazy loading automatico dopo l'avvio
class AdManager {
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;

    await MobileAds.instance.initialize();

    RequestConfiguration requestConfiguration =
        RequestConfiguration(testDeviceIds: ['1FA165CFB0DE351CE0C523D8FDA31AB3']);
    MobileAds.instance.updateRequestConfiguration(requestConfiguration);

    _isInitialized = true;
    debugPrint("✅ AdMob inizializzato.");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  setupFirebaseMessaging(navigatorKey);

  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // ✅ Lazy loading automatico di AdMob
    Future.microtask(() async {
      await AdManager.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParaLat',
      navigatorKey: widget.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          color: Theme.of(context).colorScheme.inversePrimary,
          toolbarHeight: 100,
        ),
        // bottomAppBarTheme: const BottomAppBarTheme(),
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: const WidgetStatePropertyAll(true),
          thumbColor: WidgetStatePropertyAll(Colors.deepPurple.shade100),
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const AuthPage2();
          }
        },
      ),
    );
  }
}
