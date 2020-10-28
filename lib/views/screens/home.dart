import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/utils/colors.dart';
import 'package:notesapp/utils/images.dart';
import 'package:notesapp/utils/styles.dart';
import 'package:notesapp/views/screens/detail_category.dart';
import 'package:notesapp/views/screens/new_note.dart';
import 'package:notesapp/views/widgets/custom_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 25,
          color: kWhite,
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, NewNoteScreen.routeName);
          setState(() {});
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Text(
              'Lists',
              style: textStyle(
                size: 32,
                color: Colors.black,
                weight: 5,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box('noteBox').listenable(),
            builder: (context, box, widget) {
              // convert box value into a list
              List<dynamic> boxList = box.values.toList();

              // function to filter the list
              int fromList(String filterString) {
                return boxList
                    .where((element) => element.category == filterString)
                    .toList()
                    .length;
              }

              return Expanded(
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
                              noteNum: boxList.length,
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'All',
                          imgPath: all,
                          taskNum: boxList.length,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Work',
                              img: music,
                              noteNum: fromList('Work'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Work',
                          imgPath: work,
                          taskNum: fromList('Work'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Music',
                              img: music,
                              noteNum: fromList('Music'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Music',
                          imgPath: music,
                          taskNum: fromList('Music'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Travel',
                              img: travel,
                              noteNum: fromList('Travel'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Travel',
                          imgPath: travel,
                          taskNum: fromList('Travel'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Study',
                              img: study,
                              noteNum: fromList('Study'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Study',
                          imgPath: study,
                          taskNum: fromList('Study'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Home',
                              img: home,
                              noteNum: fromList('Home'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Home',
                          imgPath: home,
                          taskNum: fromList('Home'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Play',
                              img: play,
                              noteNum: fromList('Play'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Play',
                          imgPath: play,
                          taskNum: fromList('Play'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCategoryScreen(
                              category: 'Shop',
                              img: shop,
                              noteNum: fromList('Shop'),
                            ),
                          ),
                        ),
                        child: CustomCard(
                          title: 'Shop',
                          imgPath: shop,
                          taskNum: fromList('Shop'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
