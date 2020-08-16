import 'package:moor/moor.dart';
import 'package:todorenest/persistence/database/TodoDatabase.dart';
import 'package:todorenest/persistence/database/tables/TasksTable.dart';

part 'TasksDao.g.dart';

@UseDao(tables: [TasksTable])
class TasksDao extends DatabaseAccessor<TodoDatabase> with _$TasksDaoMixin {
  TasksDao(TodoDatabase attachedDatabase) : super(attachedDatabase);

  final tasksByPriorityAndStatusOrdering = [
    (t) => OrderingTerm(expression: t.isDone, mode: OrderingMode.asc),
    (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc),
  ];

  Future addTask(TasksTableCompanion entry) {
    return into(tasksTable).insert(entry);
  }

  Stream<List<Task>> getAllTasksByPriorityAndStatus() =>
      (select(tasksTable)..orderBy(tasksByPriorityAndStatusOrdering)).watch();

  Stream<List<Task>> searchTasksByPriorityAndStatus(String name) {
    return (select(tasksTable)
          ..where((tbl) => tbl.name.like('%' + name + '%'))
          ..orderBy(tasksByPriorityAndStatusOrdering))
        .watch();
  }

  Stream<List<Task>> getGetTasksWithCompletionStatus(bool isDone) =>
      (select(tasksTable)..where((t) => t.isDone.equals(isDone))).watch();

  Future setTaskAsDone(int taskId) =>
      (update(tasksTable)..where((t) => t.id.equals(taskId)))
          .write(TasksTableCompanion(isDone: Value(true)));
}
