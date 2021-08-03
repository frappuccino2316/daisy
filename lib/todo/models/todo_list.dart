import 'package:daisy/todo/models/todo.dart';

class TodoList {
  List<Todo> items;

  TodoList(this.items);

  void add(Todo todo) {
    items.add(todo);
  }

  void removeAt(int index) {
    items.removeAt(index);
  }
}
