import 'package:drift/drift.dart';

class TypeTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get typeName => text()();
}

class TaskTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get type => integer().references(TypeTable, #id)();
}

class AttendantTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get taskId => integer().references(TaskTable, #id)();
}