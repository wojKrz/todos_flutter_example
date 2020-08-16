import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todorenest/domain/model/TaskModel.dart';

import '../../localization.dart';

abstract class TaskListWidgetCreator {
  Widget buildWidget(BuildContext context);
}

class TaskSeparatorWidgetCreator extends TaskListWidgetCreator {
  final int priority;

  TaskSeparatorWidgetCreator(this.priority);

  @override
  Widget buildWidget(BuildContext context) {
    String text;
    Color color;
    if (priority == 1) {
      text = ReNestLocalizations.of(context).highPriority;
      color = Colors.red;
    } else if (priority == 2) {
      text =               ReNestLocalizations.of(context).normalPriority;
      color = Colors.green;
    } else if (priority == 3) {
      text =               ReNestLocalizations.of(context).lowPriority;
      color = Colors.blue;
    }
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}

class TaskItemWidgetCreator extends TaskListWidgetCreator {
  final TaskModel _taskModel;
  final Function(int id) _onTapActive;

  TaskItemWidgetCreator(this._taskModel, this._onTapActive);

  @override
  Widget buildWidget(BuildContext context) {
    if (_taskModel.isDone) {
      return _produceCompletedTaskItemWidget(_taskModel);
    } else {
      return _produceActiveTaskItemWidget(_taskModel, _onTapActive);
    }
  }

  Widget _produceActiveTaskItemWidget(TaskModel task, onTap(int)) {
    return Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: InkWell(
            onTap: () => onTap(task.id),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(Icons.check_circle_outline)),
                    Text(
                      task.title,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ))));
  }

  Widget _produceCompletedTaskItemWidget(TaskModel task) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Icon(Icons.check_circle)),
            Text(
              task.title,
              style: TextStyle(decoration: TextDecoration.lineThrough),
            )
          ],
        ));
  }
}

List<TaskListWidgetCreator> produceTaskItemWidgets(
    BuildContext context, List<TaskModel> models, onTapActive(int)) {
  final List<TaskListWidgetCreator> highPriority = models
      .where((element) => element.priority == 1 && !element.isDone)
      .map((task) => TaskItemWidgetCreator(task, onTapActive))
      .toList(growable: false);
  final List<TaskListWidgetCreator> highPriorityHeader =
      highPriority.length != 0 ? [TaskSeparatorWidgetCreator(1)] : [];

  final normalPriority = models
      .where((element) => element.priority == 2 && !element.isDone)
      .map((task) => TaskItemWidgetCreator(task, onTapActive))
      .toList(growable: false);
  final List<TaskSeparatorWidgetCreator> normalPriorityHeader =
      normalPriority.length != 0 ? [TaskSeparatorWidgetCreator(2)] : [];

  final lowPriority = models
      .where((element) => element.priority == 3 && !element.isDone)
      .map((task) => TaskItemWidgetCreator(task, onTapActive))
      .toList(growable: false);

  final List<TaskSeparatorWidgetCreator> lowPriorityHeader =
      lowPriority.length != 0 ? [TaskSeparatorWidgetCreator(3)] : [];

  final done = models
      .where((element) => element.isDone)
      .map((task) => TaskItemWidgetCreator(task, null))
      .toList(growable: false);

  return highPriorityHeader
    ..addAll(highPriority)
    ..addAll(normalPriorityHeader)
    ..addAll(normalPriority)
    ..addAll(lowPriorityHeader)
    ..addAll(lowPriority)
    ..addAll(done);
}
