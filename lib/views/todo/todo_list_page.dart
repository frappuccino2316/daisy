import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/todo.dart';
import 'create_todo_page.dart';
import 'edit_todo_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _todoBox = Hive.box('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: _todoBox.values.toList().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
              ),
              child: ListTile(
                title: Text(_todoBox.values.toList()[index].title),
                subtitle:
                    Text(_todoBox.values.toList()[index].toStringDeadline()),
                trailing: PopupMenuButton<String>(
                  onSelected: (String selected) {
                    popUpMenuSelected(selected, index);
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        child: Text('編集'),
                        value: '編集',
                      ),
                      const PopupMenuItem(
                        child: Text('削除'),
                        value: '削除',
                      ),
                    ];
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo? todo = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateTodoPage()));
          if (todo != null) {
            _todoBox.add(todo);
            setState(() {});
          }
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void popUpMenuSelected(String selected, int index) async {
    Todo _todoItem = _todoBox.values.toList()[index];

    switch (selected) {
      case '編集':
        final Todo? todo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTodoPage(_todoItem)));
        if (todo != null) {
          setState(() {
            _todoItem.title = todo.title;
            _todoItem.description = todo.description;
            _todoItem.deadLine = todo.deadLine;
            _todoItem.save();
          });
        }
        break;
      case '削除':
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(_todoBox.values.toList()[index].title),
                  content: Text(_todoBox.values.toList()[index].description),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        _todoBox.deleteAt(index);
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
        break;

      default:
        break;
    }
  }
}
