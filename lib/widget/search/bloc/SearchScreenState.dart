import 'package:equatable/equatable.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

abstract class SearchScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class IsLoadingResultState extends SearchScreenState {}

class HasResultListState extends SearchScreenState {
  final List<TaskModel> result;

  HasResultListState(this.result);

  @override
  List<Object> get props => [result];
}

class EmptyResultListState extends SearchScreenState {}
