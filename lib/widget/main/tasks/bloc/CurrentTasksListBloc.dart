import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/domain/TasksRepository.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListEvents.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListState.dart';

class CurrentTasksListBloc
    extends Bloc<CurrentTasksListEvent, CurrentTasksListState> {
  final TasksRepository _tasksRepository;

  CurrentTasksListBloc(this._tasksRepository) : super(LoadingCurrentTasks()) {
    _tasksRepository.getTasksSortedByPriority()
    .listen((event) {
      add(HasNewListOfTasks(event));
    });
  }


  @override
  Stream<CurrentTasksListState> mapEventToState(
      CurrentTasksListEvent event) async* {
    if (event is HasNewListOfTasks) {
      final sortedTasks = event.tasks;

      if (sortedTasks.isNotEmpty) {
        yield ListOfCurrentTasksState(sortedTasks);
      } else {
        yield NoCurrentTasksFoundState();
      }
    }

    if (event is MarkTaskAsDone) {
      await _tasksRepository.markTaskAsDone(event.taskId);
    }
  }
}
