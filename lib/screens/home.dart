import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/models/note.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // creating a box to store data
  Box _noteBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.registerAdapter(NoteAdapter(),);
    _openBox();
  }

  Future _openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _noteBox = await Hive.openBox('noteBox');
    return;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
