import 'package:equatable/equatable.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

abstract class CompletedTaskListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DisplayListOfCompletedTasksEvent extends CompletedTaskListEvent {
  final List<TaskModel> list;

  DisplayListOfCompletedTasksEvent(this.list);
}