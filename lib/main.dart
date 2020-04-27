import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/database/database.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/screens/detail_category.dart';
import 'package:notesapp/screens/home.dart';
import 'package:notesapp/screens/new_note.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openBox();
  }

  Future _openBox() async{
    Box _noteBox;
    Hive.registerAdapter(
      NoteAdapter(),
    );
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _noteBox = await Hive.openBox('noteBox');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NewNoteScreen.routeName: (context) => NewNoteScreen(note: Note(),action: 'Add Note',),
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
