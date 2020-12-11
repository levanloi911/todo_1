import 'package:flutter/cupertino.dart';



class Todo {
  String title;
  String id;
  String time;
  bool isDone;

  Todo({
    @required
    this.id,
    this.title,
    this.time = '',
    this.isDone = false,
  });

  Todo.fromMap(Map map) :
        this.id = map['id'],
        this.title = map['title'],
         this.time = map['time'],
         this.isDone = map['isDone'];

  Map toMap(){
    return {
      'id': this.id,
      'title': this.title,
      'time': this.time,
      'isDone': this.isDone,
    };
  }
}
