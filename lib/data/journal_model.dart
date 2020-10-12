import 'package:flutter_idea_analyzer/data/model.dart';

class JournalModel extends Model {
  static String table = 'journal';

  
}

class JournalItem {
  int id;
  DateTime created;
  DateTime changed;
  String description;
  String comment;
}
