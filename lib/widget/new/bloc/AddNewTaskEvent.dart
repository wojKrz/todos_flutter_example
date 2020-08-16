import 'package:equatable/equatable.dart';

abstract class AddNewTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTaskTemplatesEvent extends AddNewTaskEvent {}

class StartPrioritySelectionForEvent extends AddNewTaskEvent {
  final int taskId;

  StartPrioritySelectionForEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class AddSelectedTaskEvent extends AddNewTaskEvent {
  final int priority;

  AddSelectedTaskEvent(this.priority);

  @override
  List<Object> get props => [priority];
}
