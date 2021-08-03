import 'package:daisy/todo/models/todo.dart';

class TodoList {
  List<Todo> items;

  TodoList(this.items);

  TodoList add(Todo todo) {
    TodoList todoList = TodoList(this.items);
    todoList.items.add(todo);
    return todoList;
  }

  TodoList removeAt(int index) {
    TodoList todoList = TodoList(this.items);
    todoList.items.removeAt(index);
    return todoList;
  }
}
