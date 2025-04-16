import 'package:drift/drift.dart';
import '../app_database.dart';

/// Interface for migration scripts
abstract class MigrationScript {
  Future<void> migrate(AppDatabase db);
  int get version;
}

/// Migration from v1 to v2
class MigrationV1ToV2 implements MigrationScript {
  @override
  int get version => 2;
  
  @override
  Future<void> migrate(AppDatabase db) async {
    await db.customStatement('ALTER TABLE user_table ADD COLUMN lastname TEXT');
  }
}

/// Migration from v2 to v3
class MigrationV2ToV3 implements MigrationScript {
  @override
  int get version => 3;
  
  @override
  Future<void> migrate(AppDatabase db) async {
    await db.customStatement('ALTER TABLE user_table ADD COLUMN lastname2 TEXT');
  }
}

/// Migration from v3 to v4
class MigrationV3ToV4 implements MigrationScript {
  @override
  int get version => 4;
  
  @override
  Future<void> migrate(AppDatabase db) async {
    await db.customStatement('ALTER TABLE user_table DROP COLUMN lastname2');
  }
}

/// Class that manages the migration process
class DatabaseMigrator {
  final AppDatabase db;
  final List<MigrationScript> _migrations = [
    MigrationV1ToV2(),
    MigrationV2ToV3(),
    MigrationV3ToV4(),
    // Add new migrations here
  ];
  
  DatabaseMigrator(this.db);
  
  /// Runs all migrations needed to go from [fromVersion] to [toVersion]
  Future<void> migrateFromTo(int fromVersion, int toVersion) async {
    // Sort migrations by version to ensure proper sequence
    _migrations.sort((a, b) => a.version.compareTo(b.version));
    
    // Apply each migration that is needed
    for (final migration in _migrations) {
      if (migration.version > fromVersion && migration.version <= toVersion) {
        await _applyMigration(migration);
      }
    }
  }
  
  Future<void> _applyMigration(MigrationScript migration) async {
    try {
      await db.transaction(() async {
        await migration.migrate(db);
      });
      
      print('Applied migration to version ${migration.version}');
    } catch (e) {
      print('Failed to apply migration to version ${migration.version}: $e');
      rethrow;
    }
  }
}