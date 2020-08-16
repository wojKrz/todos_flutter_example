import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ReNestLocalizations {
  static ReNestLocalizations of(BuildContext context) {
    return Localizations.of<ReNestLocalizations>(context, ReNestLocalizations);
  }

  String get appName => Intl.message("ReNest", name: "appName");

  String get addTask => Intl.message("Add task", name: "addTask");

  String get tasks => Intl.message("Tasks", name: "tasks");

  String get completed => Intl.message("Completed", name: "completed");

  String get noTasks => Intl.message("No tasks", name: "noTasks");

  String get highPriority => Intl.message("High priority", name: "highPriority");

  String get normalPriority => Intl.message("Normal priority", name: "normalPriority");

  String get lowPriority => Intl.message("Low priority", name: "lowPriority");
  
  String get searchHint => Intl.message("Search by name", name: "searchHint");

}

class ReNestLocalizationsDelegate
    extends LocalizationsDelegate<ReNestLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");

  @override
  Future<ReNestLocalizations> load(Locale locale) =>
      Future(() => ReNestLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<ReNestLocalizations> old) => false;
}
