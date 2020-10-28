import 'package:flutter/material.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/utils.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String imgPath;
  final int taskNum;

  const CustomCard({this.title, this.imgPath, this.taskNum});

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
        height: DeviceUtil(context).screenWidth(extent: 0.9),
        width: DeviceUtil(context).screenWidth(extent: 0.30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            YBox(20),
            Image(
              height: 55,
              width: 55,
              image: AssetImage(imgPath),
              fit: BoxFit.contain,
            ),
            YBox(10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: kBlack),
            ),
            YBox(5),
            Text(
              '$taskNum ${taskNum > 1 ? 'Notes' : 'Note'}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: kGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
