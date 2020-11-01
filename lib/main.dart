import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/core/database/database.dart';
import 'package:notesapp/core/models/note.dart';
import 'package:notesapp/views/screens/home.dart';
import 'package:notesapp/views/screens/new_note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().openBox();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NewNoteScreen.routeName: (context) => NewNoteScreen(
              note: Note(),
              action: 'Add Note',
            ),
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
