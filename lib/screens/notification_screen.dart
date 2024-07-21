import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../service/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationService notificationService = NotificationService();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    notificationService.requestNotificationPermission();
    // notificationService.firebaseInit(context);
    // notificationService.setupInteractMessage(context);
    // notificationService.getToken().then((value){
    //   if (kDebugMode) {
    //     print(value.toString());
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [

                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter title'
                  ),
                ),
                const SizedBox(height: 10,),

                TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter message'
                  ),
                ),
                const SizedBox(height: 10,),

                ElevatedButton(
                  onPressed: () {
                    notificationService.getToken().then((value) async{

                      var data = {
                        'to' : value.toString(),
                        'priority' : 'high',
                        'notification' : {
                          'title' : titleController.text.toString(),
                          'body' : messageController.text.toString()
                        },
                        'data' : {
                          'type' : 'user',
                        }
                      };

                      var i = await http.post(
                          Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type' : 'application/json; charset=UTF-8',
                          'Authorization' : 'key=AAAAPQN3kOM:APA91bFXab7Y1_FDIBAxe1pTslYEr1nEkzfPQfshTysrHjbP0x8w2lgYlKpvk-FSF2_9PEGkICu9w5ujHTI32oibvwhIDysFmfHDjfJanCSlSHAzjopX8lCUUolbocENUdz1B1jZK2J9',
                        }
                      );

                    });
                  },
                  child: const Text("device"),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {

              var notification = FlutterLocalNotificationsPlugin();
              // initialize plugin
              notification.initialize(const InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher")));
              // show
              notification.show("".hashCode, "From Firebase", 'Hello dear users', const NotificationDetails(
                android: AndroidNotificationDetails("channelId", "channelName", priority: Priority.high, importance: Importance.high, channelShowBadge: true)
              ));
            },
            child: const Text("Show local notification"),
          ),
        ],
      ),
    );
  }

}


/*

   for server key (Authorization)
   --project setting
   --Cloud Messaging API (Legacy)
   -- click on three dot icon
   -- enable api
   -- back firebase console
   -- page refresh
   -- copy server key

* */