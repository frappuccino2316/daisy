import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:daisy/models/todo/todo.dart';
import 'package:daisy/view_models/todo/todo_view_models.dart';

void main() async {
  await initialiseHive();

  group('Test TodoViewModel', () {
    tearDown(() async {
      await Hive.deleteFromDisk();
    });

    test('TodoViewModel can create in hive', () async {
      await Hive.openBox('calendar_event');
      TodoViewModel _viewModel = TodoViewModel();

      Todo _todo = Todo('test1', 'detail test 1', DateTime.utc(1996, 2, 15));
      _viewModel.addTodo(_todo);

      List _todoList = _viewModel.getAllTodo();
      expect(_todoList, [_todo]);
    });

    test('TodoViewModel can update in hive', () async {
      await Hive.openBox('calendar_event');
      TodoViewModel _viewModel = TodoViewModel();

      Todo _todo = Todo('test1', 'detail test 1', DateTime.utc(1996, 2, 15));
      _viewModel.addTodo(_todo);

      Todo _calendarEventFirst = _viewModel.getAllTodo()[0];
      _calendarEventFirst.title = 'test2';
      _calendarEventFirst.description = 'description test 2';
      _calendarEventFirst.deadLine = DateTime.utc(2000, 1, 1);
      _calendarEventFirst.save();

      expect(_viewModel.getAllTodo()[0].title, 'test2');
      expect(_viewModel.getAllTodo()[0].description, 'description test 2');
      expect(_viewModel.getAllTodo()[0].deadLine, DateTime.utc(2000, 1, 1));
    });
  });
}

Future<void> initialiseHive() async {
  final path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(TodoAdapter());

  Hive.deleteFromDisk();
}
