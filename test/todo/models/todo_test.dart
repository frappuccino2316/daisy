import 'package:flutter_test/flutter_test.dart';

import 'package:daisy/todo/models/todo.dart';

void main() {
  group('Todo', () {
    test('Todo should return String deadline', () {
      Todo todo = Todo('test1', 'description\n詳細情報です',
          DateTime.parse('1996-02-15 20:18:04Z'));
      expect(todo.toStringDeadline(), '1996年2月15日');
    });
  });
}
