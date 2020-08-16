import 'package:equatable/equatable.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

abstract class CurrentTasksListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingCurrentTasks extends CurrentTasksListState {}

class ListOfCurrentTasksState extends CurrentTasksListState {
  final List<TaskModel> tasks;

  ListOfCurrentTasksState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class NoCurrentTasksFoundState extends CurrentTasksListState {}
