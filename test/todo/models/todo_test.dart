import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:daisy/todo/models/todo.dart';

void main() {
  group('Todo', () {
    test('Todo title should match argument', () {
      final todo = Todo('test1', Icons.add, DateTime.now());
      expect(todo.title, 'test1');
    });

    test('Todo icon should match argument', () {
      final todo = Todo('test1', Icons.add, DateTime.now());
      expect(todo.icon, Icons.add);
    });
  });
}
