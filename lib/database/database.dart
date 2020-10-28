import 'dart:io';

import 'package:hive/hive.dart';
import 'package:notesapp/models/note.dart';

class DatabaseService {

  static Future openBox() async {
    var path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter(NoteAdapter());

    // var box = await Hive.openBox('noteBox');
  }

}
