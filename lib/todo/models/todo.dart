import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Todo {
  String title;
  DateTime deadLine;

  Todo(this.title, this.deadLine);

  String toStringDeadline() {
    initializeDateFormatting('ja');
    DateFormat format = DateFormat.yMMMd('ja');
    String date = format.format(deadLine);
    return date;
  }
}
