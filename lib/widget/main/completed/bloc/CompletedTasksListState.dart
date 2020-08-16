import 'package:equatable/equatable.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

abstract class CompletedTasksListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingCompletedTasksState extends CompletedTasksListState {}

class ListOfCompletedTasksState extends CompletedTasksListState {
  final List<TaskModel> tasks;

  ListOfCompletedTasksState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class NoCompletedTasksFoundState extends CompletedTasksListState {}
