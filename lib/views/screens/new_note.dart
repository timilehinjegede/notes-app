import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/core/models/note.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/images.dart';
import 'package:notesapp/utils/margin.dart';
import 'package:notesapp/utils/resolution.dart';
import 'package:notesapp/utils/styles.dart';

class NewNoteScreen extends StatefulWidget {
  final String action;
  final Note note;
  final int noteKey;

  NewNoteScreen({this.note, this.action, this.noteKey});

  static final String routeName = 'newnotescreen';
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  Box _noteBox;
  var passedNote;

  TextEditingController titleEditingController;
  TextEditingController descriptionEditingController;
  String dropdownValue;
  String dateCreated;
  String dateLastEdited;

  @override
  void initState() {
    super.initState();
    prepopulateValues();
  }

  void prepopulateValues() {
    titleEditingController = TextEditingController(text: widget.note.title);
    descriptionEditingController =
        TextEditingController(text: widget.note.description);
    dropdownValue =
        widget.note.category == null ? 'Work' : widget.note.category;
    dateCreated = widget.note.dateCreated == null
        ? DateFormat.yMMMd().format(
            DateTime.now(),
          )
        : widget.note.dateCreated;
    dateLastEdited = widget.note.dateLastEdited != null
        ? DateFormat.yMMMd().format(
            DateTime.now(),
          )
        : widget.note.dateLastEdited;
  }

  // save a new note
  void _saveNote() async {
    Note newNote = Note()
      ..title = titleEditingController.text
      ..description = descriptionEditingController.text
      ..category = dropdownValue
      ..dateCreated = DateFormat.yMMMd().format(DateTime.now())
      ..dateLastEdited = DateFormat.yMMMd().format(DateTime.now());

    // store in the database
    await _noteBox.add(newNote);
  }

  // update an exisiting note
  void _updateNote() async {
    Note existingNote = Note()
      ..title = titleEditingController.text
      ..description = descriptionEditingController.text
      ..category = dropdownValue
      ..dateCreated = widget.note.dateCreated
      ..dateLastEdited = dateLastEdited;

// convert the box to a map
    var noteMap = _noteBox.toMap();

    // filter the map based on the category screen the user is on
    noteMap.removeWhere((key, value) => !(key == widget.noteKey));

    await _noteBox.put(widget.noteKey, existingNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: widget.action == 'Update Note'
            ? Text(
                'Update Note',
                style: textStyle(
                  color: kBlack,
                  weight: 5,
                ),
              )
            : Text(
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
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: titleEditingController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Note Title',
              ),
              keyboardType: TextInputType.text,
              minLines: 2,
              maxLines: 2,
              maxLength: 70,
            ),
            YMargin(20),
            Expanded(
              child: TextFormField(
                controller: descriptionEditingController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Note Description',
                ),
                keyboardType: TextInputType.text,
                minLines: 15,
                maxLines: 15,
              ),
            ),
            YMargin(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  height: 30,
                  width: 30,
                  image: category,
                  fit: BoxFit.cover,
                ),
                XMargin(15),
                XMargin(5),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 25,
                  elevation: 16,
                  underline: YMargin(0),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Work',
                    'Music',
                    'Travel',
                    'Study',
                    'Home',
                    'Play',
                    'Shop'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            YMargin(20),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Last Edited: $dateLastEdited',
                style: textStyle(
                  size: 12,
                  color: kGreyBlack,
                  weight: 4,
                ),
              ),
            ),
            YMargin(5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Created: $dateCreated',
                style: textStyle(
                  size: 12,
                  color: kGreyBlack,
                  weight: 4,
                ),
              ),
            ),
            YMargin(30),
            GestureDetector(
              onTap: () {
                widget.action == 'Add Note'
                    ?
                    // save the note to the database
                    _saveNote()

                    // update the note present in the database
                    : _updateNote();

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
                    widget.action,
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
