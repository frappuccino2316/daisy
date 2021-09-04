import 'package:hive_flutter/hive_flutter.dart';

import 'package:daisy/models/todo/todo.dart';

class TodoViewModel {
  final _todoBox = Hive.box('todo');

  List<dynamic> getAllTodo() {
    List<dynamic> _todoList = _todoBox.values.toList();
    return _todoList;
  }

  void addTodo(Todo todo) async {
    await _todoBox.add(todo);
  }

  void editTodo(int index, Todo todo) async {
    Todo _todoInBox = getAllTodo()[index];
    _todoInBox.title = todo.title;
    _todoInBox.description = todo.description;
    _todoInBox.deadLine = todo.deadLine;
    _todoInBox.save();
  }

  void deleteTodo(int index) async {
    getAllTodo()[index].delete();
  }
}
