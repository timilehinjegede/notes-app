import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/core/models/note.dart';
import 'package:notesapp/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  final Box _noteBox = Hive.box(noteBox);

  Future openBox() async {
    var appDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDirectory.path)
      ..registerAdapter(NoteAdapter());
    await Hive.openBox(noteBox);
  }

  Future addNote(Note newNote) async {
    await _noteBox.add(newNote);
  }

  Future getNote(String noteKey) async {
    await _noteBox.get(noteKey);
  }

  Future deleteNote(String noteKey) async {
    await _noteBox.delete(noteKey);
  }

  Future updateNote(
      {@required String noteKey, @required Note updatedNote}) async {
    await _noteBox.put(noteKey, updatedNote);
  }

  List<Note> getAllNotes() => _noteBox.values.toList();

  List<Note> getNotesByCategory(String category) {
    return _noteBox.values
        .toList()
        .where((note) => note.category == category)
        .toList();
  }
}
