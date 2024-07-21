
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TestNotification{

  void showLocalNotification(RemoteMessage message){

    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

    notificationsPlugin.initialize(
      const InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"))
    );
    notificationsPlugin.show(
        "".hashCode, message.notification!.title, message.notification!.body,
        const NotificationDetails(android: AndroidNotificationDetails(
            "channel_id", "channelName", priority: Priority.high, importance: Importance.high
        )),
    );
  }

  firebaseSmsForeground(){
    FirebaseMessaging.onMessage.listen((message) {
      showLocalNotification(message);
    });
  }

  Future<String> getToken() async{
    var token = await FirebaseMessaging.instance.getToken();

    return token!;
  }
}