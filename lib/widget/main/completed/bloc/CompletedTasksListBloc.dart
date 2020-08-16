import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/domain/TasksRepository.dart';
import 'package:todorenest/widget/main/completed/bloc/CompletedTaskListEvents.dart';
import 'package:todorenest/widget/main/completed/bloc/CompletedTasksListState.dart';

class CompletedTasksListBloc
    extends Bloc<CompletedTaskListEvent, CompletedTasksListState> {
  final TasksRepository _tasksRepository;

  CompletedTasksListBloc(this._tasksRepository)
      : super(LoadingCompletedTasksState()) {
    _tasksRepository.getCompletedTasks().listen((event) {
      add(DisplayListOfCompletedTasksEvent(event));
    });
  }

  @override
  Stream<CompletedTasksListState> mapEventToState(
      CompletedTaskListEvent event) async* {
    if (event is DisplayListOfCompletedTasksEvent) {
      yield ListOfCompletedTasksState(event.list);
    }
  }
}
