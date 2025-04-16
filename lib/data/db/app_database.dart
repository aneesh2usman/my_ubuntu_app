// app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb check
import 'package:my_ubuntu_app/data/db/dao/user_dao.dart';
import 'package:my_ubuntu_app/data/db/migrations/database_migrator.dart';
import 'package:my_ubuntu_app/data/db/migrations/migration_scripts.dart';
import 'package:my_ubuntu_app/data/db/tables/user_tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [UserTable, RoleTable, UserRoleTable])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  factory AppDatabase() => _instance ??= AppDatabase._internal();

  AppDatabase._internal() : super(_openConnection()) {
    userDao =UserDao(this);
  }
  // Accessor for the TaskDao
  late final UserDao userDao;
  /// This is our db version. We need this for migration
  @override
  int get schemaVersion => 2; // Increment the schema version

  /// We will handle migration proccess here
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        /// Create all tables
        m.createAll();

        // /// Insert some data when the application is run for the first time
        // await into(roleTable).insert(
        //   RoleTableCompanion.insert(name: 'SuperAdmin'),
        // );
        // await into(roleTable).insert(
        //   RoleTableCompanion.insert(name: 'BusinessAdmin'),
        // );
        // await into(roleTable).insert(
        //   RoleTableCompanion.insert(name: 'BusinessUser'),
        // );
      },
      onUpgrade: (migrator, from, to) async {
        
        /// Run migrations
        /// /// Apply migrations automatically
        debugPrint("Upgrade from $from to $to");
         if (from < to) {
          final dbMigrator = DatabaseMigrator(this);
          await dbMigrator.migrateFromTo(migrator, from, to);
        }
        
        
        
      },
      beforeOpen: (details) async {
        print("Database version details: ${details.versionNow}, ${details.versionBefore}");
        await printDatabaseVersionInfo();
        /// Enable foreign_keys
        await customStatement('PRAGMA foreign_keys = ON');
        
      },
    );
  }

  
  Future<void> printDatabaseVersionInfo() async {
    final result = await customSelect('PRAGMA user_version').getSingle();
    final currentVersion = result.data['user_version'] as int;
    print('Database user_version: $currentVersion');
    print('App schemaVersion: $schemaVersion');
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
    if (kDebugMode) {
      return NativeDatabase.createInBackground(file, logStatements: true);
    } else {
      return NativeDatabase.createInBackground(file);
    }
  });
}

