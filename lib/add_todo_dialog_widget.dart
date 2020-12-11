import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider1/databae.dart';
import 'package:provider1/todo.dart';
import 'package:provider1/todos.dart';
import 'package:provider1/todo_form_widget.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String time = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (time) =>
                    setState(() => this.time = time),
                onSavedTodo: addTodo,
              ),
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        time: time,
      );
      insertDog(todo);
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }

  Future<void> insertDog(Todo todo) async {
    final Database db = (await database) as Database;
    await db.insert(
        'dogs',
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await insertDog(todo);
  }
}
