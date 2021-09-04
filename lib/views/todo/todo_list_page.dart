import 'package:flutter/material.dart';

import '../../models/todo/todo.dart';
import 'package:daisy/view_models/todo/todo_view_models.dart';
import '../widgets/page_app_bar.dart';
import 'create_todo_page.dart';
import 'edit_todo_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoViewModel _todoViewModel = TodoViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar('やること'),
      body: ListView.builder(
        itemCount: _todoViewModel.getAllTodo().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
              ),
              child: ListTile(
                title: Text(
                  _todoViewModel.getAllTodo()[index].title,
                  key: const Key('todoTitle'),
                ),
                subtitle:
                    Text(_todoViewModel.getAllTodo()[index].toStringDeadline()),
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
                key: const Key('tile'),
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
            _todoViewModel.addTodo(todo);
            setState(() {});
          }
        },
        tooltip: '追加',
        child: const Icon(Icons.add),
        key: const Key('add'),
      ),
    );
  }

  void popUpMenuSelected(String selected, int index) async {
    switch (selected) {
      case '編集':
        final Todo? todo = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                EditTodoPage(_todoViewModel.getAllTodo()[index])));
        if (todo != null) {
          setState(() {
            _todoViewModel.editTodo(index, todo);
          });
        }
        break;
      case '削除':
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(_todoViewModel.getAllTodo()[index].title),
                  content: Text(_todoViewModel.getAllTodo()[index].description),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        _todoViewModel.deleteTodo(index);
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
