import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/margin.dart';
import 'package:notesapp/utils/resolution.dart';
import 'package:notesapp/utils/styles.dart';

// ignore: must_be_immutable
class DetailCategoryScreen extends StatefulWidget {
  static final String routeName = 'detailcategory';

  final String category;
  int noteNum;
  final AssetImage img;

  DetailCategoryScreen({this.category, this.noteNum, this.img});

  @override
  _DetailCategoryScreenState createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
  int listLength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kWhite,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  YMargin(20),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: widget.img,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  YMargin(10),
                  Text(
                    widget.category,
                    style: textStyle(size: 30, weight: 7, color: kWhite),
                  ),
                  YMargin(5),
                  Text(
                    '${widget.noteNum} ${widget.noteNum > 1 ? 'Notes' : 'Note'}',
                    style: textStyle(size: 15, weight: 4, color: kWhite),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: screenHeight(context, percent: 0.66),
            padding: EdgeInsets.only(
              top: 20,
              left: 15,
              right: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              color: kWhite,
            ),
            child: ValueListenableBuilder(
              valueListenable: Hive.box('noteBox').listenable(),
              builder: (context, box, child) {
                List<dynamic> boxList = box.values.toList();

                // box without filtering
                List<dynamic> allBox = box.values.toList();

                // filter the list based on category
                boxList = boxList
                    .where((element) => element.category == widget.category)
                    .toList();

                listLength = allBox.length;

                return widget.noteNum != 0
                    ? ListView.builder(
                        itemCount: widget.category == 'All'
                            ? allBox.length
                            : widget.noteNum,
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                          children: <Widget>[
                            Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(
                                  () {
                                    box.deleteAt(index);
                                    widget.noteNum--;
                                  },
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Note Deleted",
                                    ),
                                  ),
                                );
                              },
                              child: _myNoteTile(
                                widget.category == 'All'
                                    ? allBox[index].title.toString()
                                    : boxList[index].title,
                                widget.category == 'All'
                                    ? allBox[index].description.toString()
                                    : boxList[index].description,
                                widget.category == 'All'
                                    ? allBox[index].dateLastEdited.toString()
                                    : boxList[index].dateLastEdited.toString(),
                              ),
                              background: Container(
                                padding: EdgeInsets.only(right: 20),
                                color: Colors.red,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete,
                                    color: kWhite,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          'Oops... Empty Category',
                          style: textStyle(
                            size: 14,
                            color: kGreyBlack,
                            weight: 6,
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _myNoteTile(
      String title, String description, String dateLastModified) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textStyle(
            size: 16,
            weight: 6,
          ),
          maxLines: 1,
        ),
        YMargin(5),
        Text(
          description,
          style: textStyle(
            size: 14,
            color: kGreyBlack,
            weight: 5,
          ),
          maxLines: 3,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        YMargin(10),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            dateLastModified,
            style: textStyle(
              size: 12,
              color: kGrey,
              weight: 6,
            ),
          ),
        )
      ],
    );
  }
}
