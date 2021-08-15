import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime deadLine;

  Todo(this.title, this.description, this.deadLine);

  String toStringDeadline() {
    initializeDateFormatting('ja');
    DateFormat format = DateFormat.yMMMd('ja');
    String date = format.format(deadLine);
    return date;
  }
}
