import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';

/// Interface for migration scripts
abstract class MigrationScript {
  int get version;
  Future<void> migrate(AppDatabase db, Migrator migrator);
}

/// Migration from v1 to v2
class MigrationV1ToV2 implements MigrationScript {
  @override
  int get version => 2;

  @override
  Future<void> migrate(AppDatabase db, Migrator migrator) async {
    await migrator.addColumn(db.userTable, db.userTable.lastname);
  }
}

/// Migration from v2 to v3
class MigrationV2ToV3 implements MigrationScript {
  @override
  int get version => 3;

  @override
  Future<void> migrate(AppDatabase db, Migrator migrator) async {
    await db.customStatement('ALTER TABLE user_table ADD COLUMN lastname2 TEXT');
  }
}

/// Migration from v3 to v4
class MigrationV3ToV4 implements MigrationScript {
  @override
  int get version => 4;

  @override
  Future<void> migrate(AppDatabase db, Migrator migrator) async {
    await db.customStatement('ALTER TABLE user_table DROP COLUMN lastname2');
  }
}

/// Migration from v4 to v5
class MigrationV4ToV5 implements MigrationScript {
  @override
  int get version => 5;

  @override
  Future<void> migrate(AppDatabase db, Migrator migrator) async {
    // Try removing `name` column if supported
    try {
      await migrator.dropColumn(db.userTable, 'name');
    } catch (e) {
      print("⚠️ Could not remove 'name' column: $e");
    }

    // Add new columns
    await migrator.addColumn(db.userTable, db.userTable.password);
    await migrator.addColumn(db.userTable, db.userTable.lastLogin);
    await migrator.addColumn(db.userTable, db.userTable.isSuperuser);
    await migrator.addColumn(db.userTable, db.userTable.username);
    await migrator.addColumn(db.userTable, db.userTable.firstName);
    await migrator.addColumn(db.userTable, db.userTable.lastName);
    await migrator.addColumn(db.userTable, db.userTable.email);
    await migrator.addColumn(db.userTable, db.userTable.isStaff);
    await migrator.addColumn(db.userTable, db.userTable.isActive);
    await migrator.addColumn(db.userTable, db.userTable.dateJoined);
    await migrator.addColumn(db.userTable, db.userTable.phoneNumber);
    await migrator.addColumn(db.userTable, db.userTable.isDeleted);
  }
}
