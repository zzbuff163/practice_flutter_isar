
import 'package:isar/isar.dart';

part 'schema.g.dart';
@collection
class Tasks {  //scene
  Id id;
  String title;
  String description;
  int taskColor;
  bool archive;

  @Backlink(to: 'task')
  final todos = IsarLinks<Todos>();  // 对应多个

  Tasks({
    this.id = Isar.autoIncrement,
    required this.title,
    this.description = '',
    this.archive = false,
    required this.taskColor,
  });
}

@collection
class Todos {             //Habit
  Id id;
  String name;
  String description;
  DateTime? todoCompletedTime;
  bool done;

  final task = IsarLink<Tasks>();  //对应一个

  Todos({
    this.id = Isar.autoIncrement,
    required this.name,
    this.description = '',
    this.todoCompletedTime,
    this.done = false,
  });
}