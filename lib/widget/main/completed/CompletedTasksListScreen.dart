import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/widget/main/TaskItemWidgetFactory.dart';
import 'package:todorenest/widget/main/completed/bloc/CompletedTasksListBloc.dart';
import 'package:todorenest/widget/main/completed/bloc/CompletedTasksListState.dart';

class CompletedTasksListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CompletedTasksListBloc, CompletedTasksListState>(
          builder: _buildScreenFromState);

  Widget _buildScreenFromState(
      BuildContext context, CompletedTasksListState state) {
    if (state is LoadingCompletedTasksState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ListOfCompletedTasksState) {
      final widgetCreators = state.tasks
          .map((task) => TaskItemWidgetCreator(task, null))
          .toList(growable: false);
      return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) =>
              widgetCreators[index].buildWidget(context));
    }
    if (state is NoCompletedTasksFoundState) {
      return Center(
        child: Text("Not found"),
      );
    }
  }
}
