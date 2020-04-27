import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/models/note.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {

  static Future openBox() async {
    var path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter(NoteAdapter());

    var box = await Hive.openBox('noteBox');
  }

}
