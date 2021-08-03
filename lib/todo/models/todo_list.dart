import 'package:daisy/todo/models/todo.dart';

class TodoList {
  List<Todo> todoItems;

  TodoList(this.todoItems);

  TodoList add(Todo todo) {
    TodoList todoList = TodoList(this.todoItems);
    todoList.add(todo);
    return todoList;
  }

  TodoList removeAt(int index) {
    TodoList todoList = TodoList(this.todoItems);
    todoList.removeAt(index);
    return todoList;
  }
}
