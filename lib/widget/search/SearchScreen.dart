import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/widget/main/TaskItemWidgetFactory.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListBloc.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListEvents.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenBloc.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenEvent.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenState.dart';

import '../../localization.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              suffixIcon: Icon(Icons.search),
              hintText: ReNestLocalizations.of(context).searchHint
            ),
            onChanged: (text) => _onNewSearchValue(context, text),
          ))
        ]),
      ),
      body: Column(children: [
        Expanded(
            child: Container(
                child: BlocBuilder<SearchScreenBloc, SearchScreenState>(
                    builder: (context, state) =>
                        _buildResultListFromState(context, state)))),
      ]));

  Widget _buildResultListFromState(
      BuildContext context, SearchScreenState state) {
    if (state is IsLoadingResultState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is HasResultListState) {
      final widgetsFactories = produceTaskItemWidgets(
          context, state.result, (id) => _onTapActiveTask(context, id));
      return ListView.builder(
          itemCount: widgetsFactories.length,
          itemBuilder: (context, index) =>
              widgetsFactories[index].buildWidget(context));
    }
    if (state is EmptyResultListState) {
      return Center(
        child: Text(ReNestLocalizations.of(context).noTasks),
      );
    }
    return Center();
  }

  void _onTapActiveTask(BuildContext context, int taskId) {
    BlocProvider.of<CurrentTasksListBloc>(context).add(MarkTaskAsDone(taskId));
  }

  void _onNewSearchValue(BuildContext context, String text) {
    BlocProvider.of<SearchScreenBloc>(context).add(SearchTasksEvent(text));
  }
}
