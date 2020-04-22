import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/screens/new_note.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/margin.dart';
import 'package:notesapp/utils/resolution.dart';
import 'package:notesapp/utils/styles.dart';

class DetailCategoryScreen extends StatefulWidget {
  static final String routeName = 'detailcategory';

  final String category;
  final int noteNum;
  final AssetImage img;

  DetailCategoryScreen({this.category, this.noteNum, this.img});

  @override
  _DetailCategoryScreenState createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
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
                return widget.noteNum != 0
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            Column(
                          children: <Widget>[
                            _myNoteTile(
                              boxList[index].title,
                              boxList[index].description,
                              boxList[index].dateLastEdited.toString(),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        ),
                        itemCount: boxList.length,
                      )
                    : Center(
                        child: Text(
                          'Oops... Empty Note',
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
