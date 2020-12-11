import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider1/databae.dart';
import 'package:provider1/todo.dart';
import 'package:provider1/todos.dart';
import 'package:provider1/todo_widget.dart';
import 'package:sqflite/sqflite.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    final todofinished = provider.todosCompleted;
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            Container(
              alignment: FractionalOffset(0, 1),
              child: Text(
                'Todo Jod',
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            new Container(
              width: screenSize.width,
              height: 250,
              child: new ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoWidget(todo: todo);
                },
              ),
            ),
            Container(
              alignment: FractionalOffset(0, 1),
              child: Text(
                'Todo Finished',
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

            ),
            new Container(
              width: screenSize.width,
              height: 250,
              child: new ListView.builder(
                itemCount: todofinished.length,
                itemBuilder: (context, index) {
                  final todo = todofinished[index];
                  return TodoWidget(todo: todo);
                },
              ),
            )
          ],
        ),
      ),

    );
  }
  Future<List<Todo>> dogs() async {
    // Get a reference to the database.
    final Database db = (await database) as Database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        time: maps[i]['time'],
      );

    }
    );


  }


}
