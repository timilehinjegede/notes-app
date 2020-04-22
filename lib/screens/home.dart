import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/screens/detail_category.dart';
import 'package:notesapp/screens/widgets/custom_card.dart';
import 'package:notesapp/screens/widgets/menu_button.dart';
import 'package:notesapp/utils/colors.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 25,
          color: kWhite,
        ),
        onPressed: () => print('add me'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => print('Working'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
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
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'All',
                          img: all,
                          noteNum: 23,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'All',
                      imgPath: all,
                      taskNum: 23,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Work',
                          img: work,
                          noteNum: 14,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'Work',
                      imgPath: work,
                      taskNum: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Music',
                          img: music,
                          noteNum: 6,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'Music',
                      imgPath: music,
                      taskNum: 6,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Travel',
                          img: travel,
                          noteNum: 1,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'Travel',
                      imgPath: travel,
                      taskNum: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Study',
                          img: study,
                          noteNum: 2,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'Study',
                      imgPath: study,
                      taskNum: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Home',
                          img: home,
                          noteNum: 14,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'Home',
                      imgPath: home,
                      taskNum: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Play',
                          img: play,
                          noteNum: 0,
                        ),
                      ),
                    ),
                    child: CustomCard(
                      title: 'Play',
                      imgPath: play,
                      taskNum: 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCategoryScreen(
                          category: 'Shop',
                          img: shop,
                          noteNum: 6,
                        ),
                      ),
                    ),
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
