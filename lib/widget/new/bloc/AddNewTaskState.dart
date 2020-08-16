import 'package:equatable/equatable.dart';

import 'TaskTemplateView.dart';

abstract class AddNewTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingTemplatesList extends AddNewTaskState {}

class ListOfTemplatesState extends AddNewTaskState {
  final List<TaskTemplateView> list;
  final TaskTemplateView selectedTask;

  ListOfTemplatesState(this.list, this.selectedTask);

  @override
  List<Object> get props => [list.hashCode, selectedTask];
}

class FinishedAddingTaskState extends AddNewTaskState {}
