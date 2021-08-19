import 'package:flutter/material.dart';

import '../widgets/page_app_bar.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar('通知'),
      body: const Center(
        child: Text('Notification'),
      ),
    );
  }
}
