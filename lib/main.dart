import 'package:paralat/Components/notifiche.dart';

import 'Components/auth.dart';
import 'screens/auth_page.dart';
import 'package:flutter/material.dart';
// import 'Components/Drawer_buttons.dart';
import 'screens/HomePage.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  setupFirebaseMessaging(navigatorKey);

  runApp(MyApp(navigatorKey: navigatorKey,));
}


class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ParaLat',
        navigatorKey: widget.navigatorKey, 
        theme: ThemeData( 
          //Ricorda implementare palette colori completa con i colori per ogni widget
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          appBarTheme: AppBarTheme(color: Theme.of(context).colorScheme.inversePrimary, toolbarHeight: 100),
          scrollbarTheme: ScrollbarThemeData(thumbVisibility: WidgetStatePropertyAll(true),thumbColor: WidgetStatePropertyAll(Colors.deepPurple.shade100))),
        darkTheme: ThemeData.dark(),
        // home: const HomePage(),
        home: StreamBuilder(
            stream: Auth().authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const AuthPage();
              }
            }));
  }
}
