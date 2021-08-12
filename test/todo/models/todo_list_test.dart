import 'package:flutter_test/flutter_test.dart';

import 'package:daisy/todo/models/todo.dart';
import 'package:daisy/todo/models/todo_list.dart';

void main() {
  group('TodoList', () {
    test('TodoList should be List<Todo>', () {
      final todoList = TodoList([
        Todo('test1', DateTime.now()),
        Todo('test2', DateTime.now()),
        Todo('test3', DateTime.now()),
      ]);
      expect(todoList.items.length, 3);
    });

    test('TodoList should include Todo', () {
      final todoList = TodoList([
        Todo('test1', DateTime.now()),
        Todo('test2', DateTime.now()),
        Todo('test3', DateTime.now()),
      ]);
      expect(todoList.items[0].title, 'test1');
    });

    test('TodoList can add Todo in list', () {
      final todoList = TodoList([
        Todo('test1', DateTime.now()),
        Todo('test2', DateTime.now()),
        Todo('test3', DateTime.now()),
      ]);
      todoList.add(Todo('test4', DateTime.now()));
      expect(todoList.items[3].title, 'test4');
    });

    test('TodoList can remove Todo in list', () {
      final todoList = TodoList([
        Todo('test1', DateTime.now()),
        Todo('test2', DateTime.now()),
        Todo('test3', DateTime.now()),
      ]);
      todoList.removeAt(0);
      expect(todoList.items[0].title, 'test2');
    });
  });
}
