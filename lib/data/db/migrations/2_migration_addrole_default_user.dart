import 'package:my_ubuntu_app/data/constant.dart';
import 'package:my_ubuntu_app/data/db/dao/user_dao.dart';
import 'package:my_ubuntu_app/data/db/migrations/migration_scripts.dart';
import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
/// Migration from v1 to v2
class MigrationV1ToV2ADDRoleDefaultUser implements MigrationScript {
  @override
  int get version => 2;

  @override
  Future<void> migrate(AppDatabase db, Migrator migrator) async {
    await db.into(db.roleTable).insert(
          RoleTableCompanion.insert(name: UserRole.superAdmin.name),
        );
    await db.into(db.roleTable).insert(
      RoleTableCompanion.insert(name: UserRole.businessAdmin.name),
    );
    await db.into(db.roleTable).insert(
      RoleTableCompanion.insert(name: UserRole.businessUser.name),
    );
    UserDao userDao = UserDao(db);
    final superAdmin = await userDao.findUserByUsername(UserRole.superAdmin.name);

    final roleData = await userDao.getRole(UserRole.superAdmin.name);
    final roleId = roleData?.id; // Use safe navigation to handle potential null
    print("*********superAdmin*******$superAdmin");
    if (superAdmin == null) {
      await userDao.insertUser(
        username: 'admin',
        email: 'admin@example.com',
        password: 'Admin@123', // Replace with your desired password    
        firstname: 'Super', // Replace with your desired first name 
        lastname: 'Admin', // Replace with your desired last name
        phoneNumber: '1234567890', // Replace with your desired phone number
        roleId: roleId ?? 0, // Use safe navigation to handle potential null
        isSuperuser: true,
      );
    }

  }
}
