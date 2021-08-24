import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/todo/todo.dart';
import 'models/calendar/calendar_event.dart';
import 'views/page_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(CalendarEventAdapter());
  await Hive.openBox('todo');
  await Hive.openBox('calendar_event');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageList(),
    );
  }
}
