import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/screens/paralatAI_page.dart';

import 'firebase_options.dart';
import 'package:paralat/Components/notifiche.dart';
import 'Components/auth.dart';
import 'screens/auth_page_2.dart';

/// ✅ AdMob initializer con lazy loading automatico dopo l'avvio
// class AdManager {
//   static bool _isInitialized = false;

//   static Future<void> init() async {
//     if (_isInitialized) return;

//     await MobileAds.instance.initialize();

//     RequestConfiguration requestConfiguration =
//         RequestConfiguration(testDeviceIds: ['1FA165CFB0DE351CE0C523D8FDA31AB3']);
//     MobileAds.instance.updateRequestConfiguration(requestConfiguration);

//     _isInitialized = true;
//     debugPrint("✅ AdMob inizializzato.");
//   }
// }

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
  // void initState() {
  //   super.initState();

  //   Future.microtask(() async {
  //     await AdManager.init();
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    // ✅ Definisci UNA volta il tuo schema colori
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7B2FF7),
    );

    return MaterialApp(
      title: 'ParaLat',
      navigatorKey: widget.navigatorKey,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,

        // ✅ Usa il colorScheme, NON Theme.of(context)
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          toolbarHeight: 70,
        ),


        iconTheme: const IconThemeData(
          color: AppColors.gradientStart,
        ),

        textTheme: TextTheme().apply(
          bodyColor: AppColors.text,
          displayColor: AppColors.text,
        ),

        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: const WidgetStatePropertyAll(true),
          thumbColor: WidgetStatePropertyAll(
            colorScheme.primary.withOpacity(0.3),
          ),
        ),
      ),

      // Dark theme disabilitata temporaneamente
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color(0xFF7B2FF7),
      //     brightness: Brightness.dark,
      //   ),
      // ),

      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const GeminiApiPage();
          } else {
            return const AuthPage2();
          }
        },
      ),
    );
  }
}