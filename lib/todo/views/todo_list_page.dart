import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo.dart';
import 'create_todo_page.dart';

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
        title: const Text('やること'),
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
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(_todoBox.values.toList()[index].title),
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
                    ),
                  ),
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
}
