import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../models/todo_list.dart';
import 'create_todo_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _todoItems = TodoList([
    Todo('牛乳を買う', Icons.description, DateTime.parse('1996-02-15 20:18:04Z')),
    Todo('物件探す', Icons.local_grocery_store,
        DateTime.parse('1994-04-14 13:00:04Z')),
  ]);

  void _addTodo(Todo todo) {
    setState(() => _todoItems.add(todo));
  }

  void _deleteTodo(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('やること'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
              ),
              child: ListTile(
                leading: Icon(
                  _todoItems.items[index].icon,
                  size: 35.0,
                ),
                title: Text(_todoItems.items[index].title),
                subtitle: Text(_todoItems.items[index].toStringDeadline()),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(_todoItems.items[index].title),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _deleteTodo(index);
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
          if (todo != null) _addTodo(todo);
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
