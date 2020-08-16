import 'package:todorenest/domain/model/TaskTemplate.dart';

class TaskTemplateView {
  final TaskTemplate taskTemplate;
  final bool isSelected;

  TaskTemplateView(this.taskTemplate, this.isSelected);
}
