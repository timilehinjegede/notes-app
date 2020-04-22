import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/margin.dart';
import 'package:notesapp/utils/resolution.dart';
import 'package:notesapp/utils/styles.dart';
import 'package:path_provider/path_provider.dart';

class NewNoteScreen extends StatefulWidget {

  static final String routeName = 'newnotescreen';
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {

  Box _noteBox;

  TextEditingController tEditingController = TextEditingController();
  TextEditingController dEditingController = TextEditingController();
  TextEditingController cEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: tEditingController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
              ),
              hintText: 'Title'
            ),
          ),
          YMargin(20),
          TextFormField(
            controller: dEditingController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                ),
                hintText: 'Description'
            ),
          ),
          YMargin(20),
          TextFormField(
            controller: cEditingController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                ),
                hintText: 'Category'
            ),
          ),
          SizedBox(
            height: 55,
            width: screenWidth(context),
            child: FlatButton(
              onPressed: () async {
                Note newNote = Note()
                    ..title = tEditingController.text
                    ..description = dEditingController.text
                    ..category = cEditingController.text;

                // store in the database
                await _noteBox.add(newNote);

                // pop
                Navigator.pop(context);
              },
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Save',
                  style: textStyle(color: kWhite),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
