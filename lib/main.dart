import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/screens/detail_category.dart';
import 'package:notesapp/screens/home.dart';
import 'package:notesapp/screens/new_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
