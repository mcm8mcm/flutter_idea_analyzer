import 'dart:async';
import 'package:flutter_idea_analyzer/data/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class Db {
  static Database _db;

  static int get _version => 1;
  static Future<void> init() async {
    if (_db != null) return;

    try {
      String path = await getDatabasesPath() + 'ideas.db';
      _db = await openDatabase(path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute('''''');
    await db.execute('''''');
  }
}
