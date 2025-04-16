import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';

/// Interface for migration scripts
abstract class MigrationScript {
  int get version;
  Future<void> migrate(AppDatabase db, Migrator migrator);
}

