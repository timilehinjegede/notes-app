import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/database/database.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/screens/detail_category.dart';
import 'package:notesapp/screens/home.dart';
import 'package:notesapp/screens/new_note.dart';
import 'package:path_provider/path_provider.dart';

Future openBox() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(
    NoteAdapter(),
  );
  await Hive.openBox('noteBox');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openBox();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
//    openBox();
    super.initState();
  }

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
