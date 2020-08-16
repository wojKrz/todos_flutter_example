import 'package:flutter/foundation.dart';
import 'package:todorenest/domain/model/TaskMapper.dart';
import 'package:todorenest/domain/model/TaskModel.dart';
import 'package:todorenest/persistence/database/TodoDatabase.dart';
import 'package:todorenest/persistence/database/dao/TasksDao.dart';

import 'model/TaskTemplate.dart';

class TasksRepository {
  final TasksDao _tasksDao;

  final _taskTemplates = [
    TaskTemplate(1, "Book professional movers"),
    TaskTemplate(2, "Prepare the house"),
    TaskTemplate(3, "Review moving plans"),
    TaskTemplate(4, "Prepare for payment"),
    TaskTemplate(5, "Pack an essentials box"),
    TaskTemplate(6, "Prepare appliances"),
    TaskTemplate(7, "Measure furniture and doorways"),
  ];

  TasksRepository(this._tasksDao);

  Stream<List<TaskModel>> searchTasksSortedByPriority(String name) =>
      _tasksDao.searchTasksByPriorityAndStatus(name).map((list) => list
          .map((e) => mapTaskPersistenceToDomain(e))
          .toList(growable: false));

  Stream<List<TaskModel>> getTasksSortedByPriority() =>
      _tasksDao.getAllTasksByPriorityAndStatus().map((list) => list
          .map((e) => mapTaskPersistenceToDomain(e))
          .toList(growable: false));

  Stream<List<TaskModel>> getCompletedTasks() {
    return _tasksDao.getGetTasksWithCompletionStatus(true).map((value) => value
        .map((e) => mapTaskPersistenceToDomain(e))
        .toList(growable: false));
  }

  Future addNewTask(String title, int priority) =>
      _tasksDao.addTask(TasksTableCompanion.insert(
          name: title, priority: priority, isDone: false));

  Future<List<TaskTemplate>> getTaskTemplates() =>
      SynchronousFuture(_taskTemplates);

  Future markTaskAsDone(int taskId) => _tasksDao.setTaskAsDone(taskId);
}
