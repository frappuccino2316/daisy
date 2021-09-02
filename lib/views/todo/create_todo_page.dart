import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../models/todo/todo.dart';
import '../../utils/pick_date.dart';
import '../widgets/page_app_bar.dart';

class CreateTodoPage extends StatefulWidget {
  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  String _title = '';
  String _description = '';
  DateTime _dateTime = DateTime.now();

  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: PageAppBar('作成'),
      body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  key: const Key('titleTextField'),
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                  ),
                  onChanged: (String text) => _title = text),
              TextField(
                  key: const Key('detailTextField'),
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
                    Text(DateFormat.yMMMd('ja').format(_dateTime)),
                    ElevatedButton(
                      key: const Key('deadlineButton'),
                      child: const Text('期限を選択'),
                      onPressed: () async {
                        final _selected = await pickDate(context);
                        if (_selected != null) {
                          setState(() => _dateTime = _selected);
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (_isError) const Text('全ての項目を設定してください'),
              ElevatedButton(
                key: const Key('addButton'),
                child: const Text('追加'),
                onPressed: () {
                  if (_title == '' || _description == '') {
                    setState(() => _isError = true);
                  } else {
                    Navigator.pop(
                        context, Todo(_title, _description, _dateTime));
                  }
                },
              ),
            ],
          ))),
    );
  }
}
