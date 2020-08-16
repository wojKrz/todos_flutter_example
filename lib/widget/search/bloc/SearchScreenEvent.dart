import 'package:equatable/equatable.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

abstract class SearchScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchTasksEvent extends SearchScreenEvent {
  final name;

  SearchTasksEvent(this.name);

  @override
  List<Object> get props  => [name];
}

class DisplayFoundTasksEvent extends SearchScreenEvent {
  final List<TaskModel> result;

  DisplayFoundTasksEvent(this.result);

  @override
  List<Object> get props => [result];
}
