import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:daisy/todo/models/todo.dart';
import 'package:daisy/todo/models/todo_list.dart';

void main() {
  group('TodoList', () {
    test('TodoList should be List<Todo>', () {
      final todoList = TodoList([
        Todo('test1', Icons.add, DateTime.now()),
        Todo('test2', Icons.minimize, DateTime.now()),
        Todo('test3', Icons.document_scanner, DateTime.now()),
      ]);
      expect(todoList.items.length, 3);
    });

    test('TodoList should include Todo', () {
      final todoList = TodoList([
        Todo('test1', Icons.add, DateTime.now()),
        Todo('test2', Icons.minimize, DateTime.now()),
        Todo('test3', Icons.document_scanner, DateTime.now()),
      ]);
      expect(todoList.items[0].title, 'test1');
      expect(todoList.items[0].icon, Icons.add);
    });

    test('TodoList can add Todo in list', () {
      final todoList = TodoList([
        Todo('test1', Icons.add, DateTime.now()),
        Todo('test2', Icons.minimize, DateTime.now()),
        Todo('test3', Icons.document_scanner, DateTime.now()),
      ]);
      todoList.add(Todo('test4', Icons.face, DateTime.now()));
      expect(todoList.items[3].title, 'test4');
      expect(todoList.items[3].icon, Icons.face);
    });

    test('TodoList can remove Todo in list', () {
      final todoList = TodoList([
        Todo('test1', Icons.add, DateTime.now()),
        Todo('test2', Icons.minimize, DateTime.now()),
        Todo('test3', Icons.document_scanner, DateTime.now()),
      ]);
      todoList.removeAt(0);
      expect(todoList.items[0].title, 'test2');
      expect(todoList.items[0].icon, Icons.minimize);
    });
  });
}
