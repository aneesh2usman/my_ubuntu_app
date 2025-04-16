import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/migrations/migration_scripts.dart';
import 'package:my_ubuntu_app/data/db/migrations/2_migration_addrole_default_user.dart';

class DatabaseMigrator {
  final AppDatabase db;
  final List<MigrationScript> _migrations = [
  MigrationV1ToV2ADDRoleDefaultUser(),
  ];

  DatabaseMigrator(this.db);

  /// Runs all migrations needed to go from [fromVersion] to [toVersion]
  Future<void> migrateFromTo(Migrator migrator, int fromVersion, int toVersion) async {
    _migrations.sort((a, b) => a.version.compareTo(b.version));

    for (final migration in _migrations) {
      if (migration.version > fromVersion && migration.version <= toVersion) {
        await _applyMigration(migration, migrator);
      }
    }
  }

  Future<void> _applyMigration(MigrationScript migration, Migrator migrator) async {
    try {
      await db.transaction(() async {
        await migration.migrate(db, migrator);
      });
      print('✅ Applied migration to version ${migration.version}');
    } catch (e) {
      print('❌ Failed to apply migration to version ${migration.version}: $e');
      rethrow;
    }
  }

  
}
