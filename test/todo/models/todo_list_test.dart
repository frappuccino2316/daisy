import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:daisy/todo/models/todo.dart';
import 'package:daisy/todo/models/todo_list.dart';

void main() {
  group('TodoList', () {
    test('TodoList should be List<Todo>', () {
      final todoList = TodoList([
        Todo('test1', Icons.add),
        Todo('test2', Icons.minimize),
        Todo('test3', Icons.document_scanner),
      ]);
      expect(todoList.items.length, 3);
    });

    test('TodoList should include Todo', () {
      final todoList = TodoList([
        Todo('test1', Icons.add),
        Todo('test2', Icons.minimize),
        Todo('test3', Icons.document_scanner),
      ]);
      expect(todoList.items[0].title, 'test1');
      expect(todoList.items[0].icon, Icons.add);
    });

    test('TodoList can add Todo in list', () {
      final todoList = TodoList([
        Todo('test1', Icons.add),
        Todo('test2', Icons.minimize),
        Todo('test3', Icons.document_scanner),
      ]);
      final addedTodoList = todoList.add(Todo('test4', Icons.face));
      expect(addedTodoList.items[3].title, 'test4');
      expect(addedTodoList.items[3].icon, Icons.face);
    });

    test('TodoList can remove Todo in list', () {
      final todoList = TodoList([
        Todo('test1', Icons.add),
        Todo('test2', Icons.minimize),
        Todo('test3', Icons.document_scanner),
      ]);
      final addedTodoList = todoList.removeAt(0);
      expect(addedTodoList.items[0].title, 'test2');
      expect(addedTodoList.items[0].icon, Icons.minimize);
    });
  });
}
