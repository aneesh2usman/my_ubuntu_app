// project_table.dart

import 'package:drift/drift.dart';

class ProjectTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get projectName => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}