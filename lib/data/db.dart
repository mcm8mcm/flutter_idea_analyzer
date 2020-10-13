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
    //Journal
    await db.execute('''CREATE TABLE journan (
    id BIGINT PRIMARY KEY UNIQUE,
    created DATETIME DEFAULT (NOW() ) NOT NULL,
    changed DATETIME NOT NULL DEFAULT (NOW() ),
    description VARCHAR (64)  DEFAULT ('') NOT NULL,
    comment     VARCHAR (250) NOT NULL DEFAULT ('') );
    ''');

    //Detail
    await db.execute('''CREATE TABLE idea_detail (
    id BIGINT PRIMARY KEY,
    idea_id BIGINT NOT NULL REFERENCES journan (id) ON DELETE CASCADE ON UPDATE NO ACTION,
    point_id INTEGER (2) NOT NULL,
    mark INTEGER (2) NOT NULL DEFAULT (0),
    comment VARCHAR (255) NOT NULL DEFAULT ('') );
    ''');
  }

  static Future<list<map<string, dynamic="">>> query(String table) async => _db.query(table);

  static Future<int> insert(String table, Model model) async => await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await _db.update(table, model.toMap(), where: 'id = ?', whereArgs:[model.id]);

  static Future<int> delete(String table, Model model) async => await _db.delete(table, where: 'id = ?', whereArgs:[model.id]);

}
