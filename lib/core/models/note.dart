import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  String dateCreated;

  @HiveField(5)
  String dateLastEdited;

  Note(
      {this.title,
      this.description,
      this.category,
      this.dateCreated,
      this.dateLastEdited});
}
