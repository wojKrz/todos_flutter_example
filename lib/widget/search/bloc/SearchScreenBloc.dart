import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/domain/TasksRepository.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenEvent.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenState.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  final TasksRepository _tasksRepository;

  SearchScreenBloc(this._tasksRepository) : super(IsLoadingResultState());

  StreamSubscription _resultSub;

  @override
  Stream<SearchScreenState> mapEventToState(SearchScreenEvent event) async* {
    if (event is SearchTasksEvent) {
      yield IsLoadingResultState();

      _resultSub?.cancel();
      _resultSub = _tasksRepository
          .searchTasksSortedByPriority(event.name)
          .listen((event) {
            add(DisplayFoundTasksEvent(event));
      });
    }

    if (event is DisplayFoundTasksEvent) {
      if (event.result.isNotEmpty) {
        yield HasResultListState(event.result);
      } else {
        yield EmptyResultListState();
      }
    }
  }
}
