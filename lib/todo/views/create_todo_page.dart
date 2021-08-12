import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class CreateTodoPage extends StatefulWidget {
  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  String _title = '';
  // IconData? _icon;
  DateTime _dateTime = DateTime.now();

  bool _isError = false;

  // void _pickIcon() async {
  //   IconData? icon = await FlutterIconPicker.showIconPicker(context);
  //   setState(() {
  //     _icon = icon;
  //   });
  // }

  void _pickDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
    );
    if (selected != null) {
      setState(() {
        _dateTime = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: const InputDecoration(
                    labelText: 'Todoタイトル',
                  ),
                  onChanged: (String text) => _title = text),
              // Container(
              //   padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       _icon != null
              //           ? Icon(_icon, size: 45.0)
              //           : const Text('アイコンを選んでください'),
              //       ElevatedButton(
              //         child: const Text('アイコンを選択'),
              //         onPressed: () => _pickIcon(),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(DateFormat.yMMMd('ja').format(_dateTime)),
                    ElevatedButton(
                      child: const Text('期限を選択'),
                      onPressed: () => _pickDate(),
                    ),
                  ],
                ),
              ),
              if (_isError) const Text('全ての項目を設定してください'),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  if (_title == '') {
                    setState(() => _isError = true);
                  } else {
                    Navigator.pop(context, Todo(_title, _dateTime));
                  }
                },
              ),
            ],
          ))),
    );
  }
}
