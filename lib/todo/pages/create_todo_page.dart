import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../models/todo.dart';

class CreateTodoPage extends StatefulWidget {
  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  String _title = '';
  IconData? _icon;

  bool _isError = false;

  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context);
    setState(() {
      _icon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('やること作成'),
      ),
      body: Container(
          padding: EdgeInsets.all(40.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  decoration: InputDecoration(
                    labelText: 'Todoタイトル',
                  ),
                  onChanged: (String text) => _title = text),
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _icon != null
                        ? Icon(_icon, size: 45.0)
                        : Text('アイコンを選んでください'),
                    ElevatedButton(
                      child: Text('アイコンを選択'),
                      onPressed: () => _pickIcon(),
                    ),
                  ],
                ),
              ),
              if (_isError) Text('全ての項目を設定してください'),
              ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  if (_title == '' || _icon == null) {
                    setState(() => _isError = true);
                  } else {
                    Navigator.pop(context, Todo(_title, _icon!));
                  }
                },
              ),
            ],
          ))),
    );
  }
}
