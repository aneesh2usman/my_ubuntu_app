// app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb check
import 'package:my_ubuntu_app/data/db/dao/task_dao.dart';
import 'package:my_ubuntu_app/data/db/models/task_models.dart';
import 'package:my_ubuntu_app/data/db/tables/task_tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TaskTable, TypeTable, AttendantTable])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  factory AppDatabase() => _instance ??= AppDatabase._internal();

  AppDatabase._internal() : super(_openConnection()) {
    taskDao = TaskDao(this); // Initialize the TaskDao
  }

  /// This is our db version. We need this for migration
  @override
  int get schemaVersion => 1;

  /// We will handle migration proccess here
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        /// Create all tables
        m.createAll();

        /// Insert some data when the application is run for the first time
        await into(typeTable).insert(
          TypeTableCompanion.insert(typeName: 'Subtask'),
        );
        await into(typeTable).insert(
          TypeTableCompanion.insert(typeName: 'Feature'),
        );
        await into(typeTable).insert(
          TypeTableCompanion.insert(typeName: 'Bug'),
        );
      },
      beforeOpen: (details) async {
        /// Enable foreign_keys
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  // Accessor for the TaskDao
  late final TaskDao taskDao;

  Future<List<TypeModel>> getAllTypes() async {
    return (await select(typeTable).get())
        .map((e) => TypeModel(id: e.id, typeName: e.typeName))
        .toList();
  }

  Future<void> closeDatabase() async {
    await close();
    _instance = null; // Optionally reset the instance on close
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.my_ubundu_app'));

    if (!kIsWeb && Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

