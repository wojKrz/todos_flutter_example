import 'package:todorenest/persistence/database/TodoDatabase.dart';
import 'package:todorenest/persistence/database/dao/TasksDao.dart';

class DatabaseModule {
  static final TodoDatabase _databaseInstance = TodoDatabase();

  static final _tasksDao = TasksDao(_databaseInstance);

  TasksDao provideTasksDao() => _tasksDao;
}
