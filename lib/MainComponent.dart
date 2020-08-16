import 'package:todorenest/domain/DomainModule.dart';
import 'package:todorenest/domain/TasksRepository.dart';
import 'package:todorenest/persistence/database/DatabaseModule.dart';

class MainComponent {
  final DomainModule _domainModule;
  final DatabaseModule _databaseModule;

  MainComponent(this._domainModule, this._databaseModule);

  TasksRepository provideTasksRepo() =>
      _domainModule.provideTasksRepo(_databaseModule.provideTasksDao());
}
