import 'package:moor/moor.dart';

@DataClassName("Task")
class TasksTable extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get priority => integer()();
  BoolColumn get isDone => boolean()();
}
