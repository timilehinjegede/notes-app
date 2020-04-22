import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/images.dart';
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

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController cEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openBox();
  }

  void _saveNote() async {
    Note newNote = Note()
      ..title = titleEditingController.text
      ..description = descriptionEditingController.text
      ..category = cEditingController.text;

    // store in the database
    await _noteBox.add(newNote);
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'New Note',
          style: textStyle(
            color: kBlack,
            weight: 5,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        iconTheme: IconThemeData(
          color: kBlack,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), hintText: 'Note Title',),
                    keyboardType: TextInputType.text,
                    minLines: 5,
                    maxLines: 5,
                    expands: false,
                  ),
                  YMargin(20),
                  TextFormField(
                    controller: descriptionEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Note Description',),
                    keyboardType: TextInputType.text,
                    minLines: 10,
                    maxLines: 10,
                  ),
                ],
              ),
            ),
            YMargin(20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  height: 30,
                  width: 30,
                  image: category,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Category'
                )
              ],
            ),
            YMargin(20),
            GestureDetector(
              onTap: (){
                // save the note to the database
                _saveNote();

                // pop
                Navigator.pop(context);
              },
              child: Container(
                height: 55,
                width: screenWidth(context),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Save Note',
                    style: textStyle(
                      color: kWhite,
                      weight: 6,
                      size: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//TextFormField(
//controller: tEditingController,
//decoration: InputDecoration(
//border: UnderlineInputBorder(
//),
//hintText: 'Title'
//),
//),
//YMargin(20),
//TextFormField(
//controller: dEditingController,
//decoration: InputDecoration(
//border: UnderlineInputBorder(
//),
//hintText: 'Description'
//),
//),
//YMargin(20),
//TextFormField(
//controller: cEditingController,
//decoration: InputDecoration(
//border: UnderlineInputBorder(
//),
//hintText: 'Category'
//),
//),
//SizedBox(
//height: 55,
//width: screenWidth(context),
//child: FlatButton(
//onPressed: () async {
//

//},
//color: Colors.blue,
//child: Center(
//child: Text(
//'Save',
//style: textStyle(color: kWhite),
//),
//),
//),
//)
