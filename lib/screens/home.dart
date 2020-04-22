import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/screens/widgets/custom_card.dart';
import 'package:notesapp/screens/widgets/menu_button.dart';
import 'package:notesapp/utils/images.dart';
import 'package:notesapp/utils/styles.dart';
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
    Hive.registerAdapter(
      NoteAdapter(),
    );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => print('Working'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: MenuButton(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Lists',
              style: textStyle(
                size: 32,
                color: Colors.black,
                weight: 5,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => print('all'),
                    child: CustomCard(
                      title: 'All',
                      imgPath: all,
                      taskNum: 23,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('work'),
                    child: CustomCard(
                      title: 'Work',
                      imgPath: work,
                      taskNum: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('music'),
                    child: CustomCard(
                      title: 'Music',
                      imgPath: music,
                      taskNum: 6,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('travel'),
                    child: CustomCard(
                      title: 'Travel',
                      imgPath: travel,
                      taskNum: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('study'),
                    child: CustomCard(
                      title: 'Study',
                      imgPath: study,
                      taskNum: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('home'),
                    child: CustomCard(
                      title: 'Home',
                      imgPath: home,
                      taskNum: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('play'),
                    child: CustomCard(
                      title: 'Play',
                      imgPath: play,
                      taskNum: 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('shop'),
                    child: CustomCard(
                      title: 'Shop',
                      imgPath: shop,
                      taskNum: 6,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
