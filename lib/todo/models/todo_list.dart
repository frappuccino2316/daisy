import 'package:daisy/todo/models/todo.dart';

class TodoList {
  List<Todo> items;

  TodoList(this.items);

  void add(Todo todo) {
    this.items.add(todo);
  }

  void removeAt(int index) {
    this.items.removeAt(index);
  }
}
