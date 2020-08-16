import 'package:todorenest/persistence/database/tables/TasksTable.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'TodoDatabase.g.dart';

LazyDatabase _openConnection() {

  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return VmDatabase(file);
  });
}

@UseMoor(tables: [TasksTable])
class TodoDatabase extends _$TodoDatabase {

  TodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
