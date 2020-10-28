import 'package:flutter/material.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/margin.dart';
import 'package:notesapp/utils/resolution.dart';
import 'package:notesapp/utils/styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final AssetImage imgPath;
  final int taskNum;

  CustomCard({this.title, this.imgPath, this.taskNum});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        height: screenWidth(context, percent: 0.9),
        width: screenWidth(context, percent: 0.30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            YMargin(20),
            Image(
              height: 55,
              width: 55,
              image: imgPath,
              fit: BoxFit.contain,
            ),
            YMargin(10),
            Text(
              title,
              style: textStyle(size: 16, weight: 5, color: kBlack),
            ),
            YMargin(5),
            Text(
              '$taskNum ${taskNum > 1 ? 'Notes' : 'Note'}',
              style: textStyle(
                size: 14,
                weight: 3,
                color: kGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
