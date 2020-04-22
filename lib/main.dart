import 'package:flutter/material.dart';
import 'package:notesapp/screens/detail_category.dart';
import 'package:notesapp/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
