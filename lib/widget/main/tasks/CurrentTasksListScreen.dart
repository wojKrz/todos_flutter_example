import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/widget/main/TaskItemWidgetFactory.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListBloc.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListEvents.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListState.dart';

import '../../../localization.dart';

class CurrentTasksListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      child: BlocBuilder<CurrentTasksListBloc, CurrentTasksListState>(
          builder: (context, state) => _buildScreenFromState(context, state)));

  Widget _buildScreenFromState(
      BuildContext context, CurrentTasksListState state) {
    if (state is LoadingCurrentTasks) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ListOfCurrentTasksState) {
      final widgetsFactories = produceTaskItemWidgets(context, state.tasks,
          (id) => _onTapActiveTask(context, id));
      return ListView.builder(
          itemCount: widgetsFactories.length,
          itemBuilder: (context, index) => widgetsFactories[index].buildWidget(context));
    }
    if (state is NoCurrentTasksFoundState) {
      return Center(
        child: Text(ReNestLocalizations.of(context).noTasks),
      );
    }
  }

  void _onTapActiveTask(BuildContext context, int taskId) {
    BlocProvider.of<CurrentTasksListBloc>(context).add(MarkTaskAsDone(taskId));
  }
}
