
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_fcm/firebase_options.dart';
import 'package:notification_fcm/screens/notification_screen.dart';
import 'package:notification_fcm/test_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(onBgSmsHandler);
  TestNotification().firebaseSmsForeground();

  runApp(const MyApp());
}

@pragma("vm:entry-point")
 Future<void> onBgSmsHandler(RemoteMessage message) async{
    Firebase.initializeApp();
    TestNotification().showLocalNotification(message);
 }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: NotificationScreen(),

    );
  }
}