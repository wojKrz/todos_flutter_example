import 'package:todorenest/domain/model/TaskModel.dart';
import 'package:todorenest/persistence/database/TodoDatabase.dart';

TaskModel mapTaskPersistenceToDomain(Task task) =>
    TaskModel(task.id, task.name, task.priority, task.isDone);
