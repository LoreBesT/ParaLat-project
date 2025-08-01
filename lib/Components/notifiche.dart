import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:paralat/screens/news_general_page.dart';
import 'package:paralat/screens/news_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Gestione delle notifiche in background
}

void setupFirebaseMessaging(GlobalKey<NavigatorState> navigatorKey) {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance
      .requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

  FirebaseMessaging.instance.subscribeToTopic('news');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      // Mostra una notifica in foreground
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (_) {
          return AlertDialog(
            title: Text(notification.title ?? 'No Title'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body ?? 'No Body')
                ],
              ),
            ),
          );
        },
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => NewsGeneralPage()),
    );
  });
}
