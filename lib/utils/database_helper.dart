import 'package:dicoding_simple_local_storage/data/model/note.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  static DatabaseHelper? _databaseHelper;

  static late Database db;

  static const String _tableName = 'notes';

  Future<Database> get database async {
    final database = await _initializeDb();
    db = database;
    return database;
  }

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final db = openDatabase(
      join(path, 'note_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY,title TEXT, description TEXT)',
        );
        // await db.execute(
        //   '''CREATE TABLE $_tableName (
        //        id INTEGER PRIMARY KEY,
        //        title TEXT, description TEXT
        //      )''',
        // );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(_tableName, note.toMap());
    if (kDebugMode) {
      print('Data saved');
    }
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Note.fromMap(res)).toList();
  }

  Future<Note> getNoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => Note.fromMap(res)).first;
  }

  Future<void> updateNote(Note note) async {
    final db = await database;

    await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
