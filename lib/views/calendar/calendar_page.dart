import 'package:flutter/material.dart';

import '../widgets/page_app_bar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar('メモ'),
      body: const Center(
        child: Text('Calendar'),
      ),
    );
  }
}
