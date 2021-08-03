import 'package:daisy/todo/models/todo.dart';

class TodoList {
  List<Todo> todoItems;

  TodoList(this.todoItems);

  void add(Todo todo) {
    this.todoItems.add(todo);
  }

  void removeAt(int index) {
    this.todoItems.removeAt(index);
  }
}
