import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void database() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),

    onCreate: (db, version) {

      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, title TEXT, time TEXT)",
      );
    },

    version: 1,
  );



}
