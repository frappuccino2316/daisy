import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../models/todo.dart';
import '../../utils/pick_date.dart';

@immutable
class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage(this.todo);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  String _title = '';
  String _description = '';
  DateTime _deadLine = DateTime.now();

  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _title = widget.todo.title;
    _description = widget.todo.description;
    _deadLine = widget.todo.deadLine;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: const Text('やること作成'),
      ),
      body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: TextEditingController(text: widget.todo.title),
                  decoration: const InputDecoration(
                    labelText: 'Todoタイトル',
                  ),
                  onChanged: (String text) => _title = text),
              TextField(
                  controller:
                      TextEditingController(text: widget.todo.description),
                  decoration: const InputDecoration(
                    labelText: '詳細',
                  ),
                  onChanged: (String description) =>
                      _description = description),
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(DateFormat.yMMMd('ja').format(_deadLine)),
                    ElevatedButton(
                        child: const Text('期限を選択'),
                        onPressed: () async {
                          final _selected = await pickDate(context, _deadLine);
                          if (_selected != null) {
                            setState(() => _deadLine = _selected);
                          }
                        }),
                  ],
                ),
              ),
              if (_isError) const Text('全ての項目を設定してください'),
              ElevatedButton(
                child: const Text('更新'),
                onPressed: () {
                  if (_title == '' || _description == '') {
                    setState(() => _isError = true);
                  } else {
                    Navigator.pop(
                        context, Todo(_title, _description, _deadLine));
                  }
                },
              ),
            ],
          ))),
    );
  }
}
