import 'package:todorenest/domain/TasksRepository.dart';
import 'package:todorenest/persistence/database/dao/TasksDao.dart';

class DomainModule {

  TasksRepository provideTasksRepo(TasksDao tasksDao) =>
      TasksRepository(tasksDao);

}
