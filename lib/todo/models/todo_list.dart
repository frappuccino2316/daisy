import 'package:daisy/todo/models/todo.dart';

class TodoList {
  List<Todo> todoList;

  TodoList(this.todoList);

  void add(Todo todo) {
    this.todoList.add(todo);
  }

  void removeAt(int index) {
    this.todoList.removeAt(index);
  }
}
