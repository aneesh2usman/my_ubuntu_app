import 'package:drift/drift.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().nullable().unique()(); // Added .unique() for username
  TextColumn get email => text().nullable().unique()(); // Added .unique() for email
  TextColumn get firstname => text().nullable()();
  TextColumn get lastname => text().nullable()();
  TextColumn get password => text().nullable()();
  TextColumn get salt => text().nullable()();
  
  DateTimeColumn get lastLogin => dateTime().nullable()();
  BoolColumn get isSuperuser => boolean().withDefault(const Constant(false))();
  
  BoolColumn get isStaff => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get dateJoined => dateTime().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  // add Version 5 ends
}
class RoleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()(); // Ensure role names are unique
 
}

class UserRoleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get roleId => integer().references(RoleTable, #id,onDelete: KeyAction.cascade)();
  

  // You can add additional columns here if needed,
  // such as a timestamp for when the role was assigned.

  @override
  List<Set<Column>> get uniqueKeys => [
    {userId, roleId},
  ]; // Enforce unique user-role combinations
}
