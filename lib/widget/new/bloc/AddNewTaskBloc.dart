import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorenest/domain/TasksRepository.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskEvent.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskState.dart';
import 'package:todorenest/widget/new/bloc/TaskTemplateView.dart';

class AddNewTaskBloc extends Bloc<AddNewTaskEvent, AddNewTaskState> {
  final TasksRepository _tasksRepository;

  AddNewTaskBloc(this._tasksRepository) : super(LoadingTemplatesList());

  @override
  Stream<AddNewTaskState> mapEventToState(AddNewTaskEvent event) async* {
    if (event is LoadTaskTemplatesEvent) {
      final templates = await _tasksRepository.getTaskTemplates().then((list) =>
          list.map((e) => TaskTemplateView(e, false)).toList(growable: false));
      yield ListOfTemplatesState(templates, null);
    }
    if (event is StartPrioritySelectionForEvent) {
      if (state is ListOfTemplatesState) {
        final stateSnapshot = state as ListOfTemplatesState;
        int taskIdToSelect;
        if (event.taskId == stateSnapshot.selectedTask?.taskTemplate?.id) {
          taskIdToSelect = -1;
        } else {
          taskIdToSelect = event.taskId;
        }
        final tasks = stateSnapshot.list;
        final templatesWithSelection = tasks
            .map((e) => TaskTemplateView(
                e.taskTemplate, e.taskTemplate.id == taskIdToSelect))
            .toList(growable: false);
        final selectedTask = tasks
            .firstWhere((element) => element.taskTemplate.id == taskIdToSelect, orElse: () => null);
        yield ListOfTemplatesState(templatesWithSelection, selectedTask);
      }
    }
    if (event is AddSelectedTaskEvent) {
      if (state is ListOfTemplatesState) {
        final currentState = state as ListOfTemplatesState;
        _tasksRepository.addNewTask(
            currentState.selectedTask.taskTemplate.title, event.priority);
        yield FinishedAddingTaskState();
      }
    }
  }
}
