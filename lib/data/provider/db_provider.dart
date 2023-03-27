import 'package:dicoding_simple_local_storage/data/model/note.dart';
import 'package:dicoding_simple_local_storage/utils/database_helper.dart';
import 'package:flutter/foundation.dart';

class DbProvider extends ChangeNotifier {
  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllNotes();
  }

  List<Note> _notes = [];
  late DatabaseHelper _dbHelper;

  List<Note> get notes => _notes;

  Future<void> _getAllNotes() async {
    _notes = await _dbHelper.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _dbHelper.insertNote(note);
    await _getAllNotes();
  }

  Future<Note> getNoteById(int id) async {
    final res = await _dbHelper.getNoteById(id);
    return res;
  }

  Future<void> updateNote(Note note) async {
    await _dbHelper.updateNote(note);
    await _getAllNotes();
  }

  Future<void> deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    await _getAllNotes();
  }
}
