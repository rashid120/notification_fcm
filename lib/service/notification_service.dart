
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_fcm/screens/show_notification.dart';

class NotificationService{

  // get token and request notification permission
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  requestNotificationPermission() async{

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
      provisional: true,
      carPlay: true,
      criticalAlert: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){

      if (kDebugMode) {
        print('User permission granted');
      }
    }
    else if(settings.authorizationStatus == AuthorizationStatus.provisional){

      if (kDebugMode) {
        print('User provisional permission granted');
      }
    }
    else{

      if (kDebugMode) {
        print("User permission not granted");
      }
      // AppSettings.openAppSettings();
    }
  }

  // sent notification from firebase
  void firebaseInit(BuildContext context){

    FirebaseMessaging.onMessage.listen((message) {
      var notificationPlugin = FlutterLocalNotificationsPlugin();

      // initialize plugin
      notificationPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher")
        ),
        onDidReceiveNotificationResponse: (payload) {
          handleNotification(context, message);
        },
      );
      //show notification
      notificationPlugin.show(
          "".hashCode,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  "channelId",
                  "channelName",
                  importance: Importance.high
              )
          )
      );
    });
  }

  Future<String> getToken() async{

    var token = await messaging.getToken();
    return token!;
  }

  void handleNotification(BuildContext context, RemoteMessage message){
    if(message.data['type'] == 'user'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowNotification(
          title: message.notification!.title.toString(),
          body: message.notification!.body.toString()
      )));
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null){
      handleNotification(context, initialMessage);
    }
    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleNotification(context, event);
    });
  }
}