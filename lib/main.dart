import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/todo/todo.dart';
import 'views/page_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('todo');
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
