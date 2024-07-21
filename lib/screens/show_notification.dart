
import 'package:flutter/material.dart';

class ShowNotification extends StatefulWidget {
  const ShowNotification({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  State<ShowNotification> createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title : ${widget.title}"),
            Text("Message : ${widget.body}"),
          ],
        ),
      ),
    );
  }
}
