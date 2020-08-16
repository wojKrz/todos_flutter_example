import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/domain/model/TaskTemplate.dart';
import 'package:todorenest/localization.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListBloc.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListEvents.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskBloc.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskEvent.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskState.dart';

import 'bloc/TaskTemplateView.dart';

class AddNewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(ReNestLocalizations.of(context).addTask)),
      backgroundColor: Colors.white,
      body: BlocListener<AddNewTaskBloc, AddNewTaskState>(
          listener: (context, state) {
            if (state is FinishedAddingTaskState) {
              Builder(
                builder: (context) {
                  BlocProvider.of<CurrentTasksListBloc>(context)
                      .add(LoadCurrentTasksEvent());
                },
              );

              Navigator.pop(context);
            }
          },
          child: BlocBuilder<AddNewTaskBloc, AddNewTaskState>(
              buildWhen: (prev, curr) => !(curr is FinishedAddingTaskState),
              builder: (context, state) =>
                  _buildScreenFromState(context, state))));

  Widget _buildScreenFromState(BuildContext context, AddNewTaskState state) {
    if (state is ListOfTemplatesState) {
      return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) =>
              _buildTaskTemplateItem(context, state.list[index]));
    }
    if (state is LoadingTemplatesList) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center();
  }

  Widget _buildTaskTemplateItem(
      BuildContext context, TaskTemplateView templateView) {
    Widget content;
    if (templateView.isSelected) {
      content = Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 3,
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  ReNestLocalizations.of(context).highPriority,
                  textAlign: TextAlign.center,
                ),
                onPressed: () => _onSelectPriorityForTaskPressed(context, 1),
              ),
            ),
            Spacer(),
            Flexible(
                flex: 3,
                child: MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text(ReNestLocalizations.of(context).normalPriority,
                      textAlign: TextAlign.center),
                  onPressed: () => _onSelectPriorityForTaskPressed(context, 2),
                )),
            Spacer(),
            Flexible(
                flex: 3,
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(ReNestLocalizations.of(context).lowPriority,
                      textAlign: TextAlign.center),
                  onPressed: () => _onSelectPriorityForTaskPressed(context, 3),
                ))
          ],
        ),
      );
    } else {
      content = Text(templateView.taskTemplate.title);
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          content,
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  _onAddTaskPressed(context, templateView.taskTemplate))
        ],
      ),
    );
  }

  void _onAddTaskPressed(BuildContext context, TaskTemplate clickedTask) {
    BlocProvider.of<AddNewTaskBloc>(context)
        .add(StartPrioritySelectionForEvent(clickedTask.id));
  }

  void _onSelectPriorityForTaskPressed(BuildContext context, int priority) {
    BlocProvider.of<AddNewTaskBloc>(context)
        .add(AddSelectedTaskEvent(priority));
  }
}
