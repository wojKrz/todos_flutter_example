import 'package:equatable/equatable.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

abstract class CurrentTasksListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCurrentTasksEvent extends CurrentTasksListEvent {}

class HasNewListOfTasks extends CurrentTasksListEvent {
  final List<TaskModel> tasks;

  HasNewListOfTasks(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class MarkTaskAsDone extends CurrentTasksListEvent {
  final taskId;

  MarkTaskAsDone(this.taskId);

  @override
  List<Object> get props => [taskId];
}
