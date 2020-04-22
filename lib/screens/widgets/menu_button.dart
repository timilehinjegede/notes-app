import 'package:flutter/material.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/margin.dart';

class MenuButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        YMargin(20),
        Container(
          height: 3.5,
          width: 25,
          decoration: BoxDecoration(
            color: kGreyBlack,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        YMargin(5),
        Container(
          height: 3.5,
          width: 25,
          decoration: BoxDecoration(
            color: kGreyBlack,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        YMargin(5),
        Container(
          height: 3.5,
          width: 15,
          decoration: BoxDecoration(
            color: kGreyBlack,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
