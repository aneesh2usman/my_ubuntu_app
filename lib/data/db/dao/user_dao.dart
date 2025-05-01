// user_dao.dart

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';

class UserDao {
  final AppDatabase _database;

  UserDao(this._database);

 

  
  List<Expression<bool>> getfilter (Map<String, String>? filters) {
    final List<Expression<bool>> whereClauses = [];
    if (filters != null && filters.isNotEmpty) {
      if (filters.containsKey('username')) {
        whereClauses.add(_database.userTable.username.like('%${filters['username']}%'));
      }
      if (filters.containsKey('email')) {
        whereClauses.add(_database.userTable.email.like('%${filters['email']}%'));
      }
      if (filters.containsKey('firstname')) {
        whereClauses.add(_database.userTable.firstname.like('%${filters['firstname']}%'));
      }
      if (filters.containsKey('lastname')) {
        whereClauses.add(_database.userTable.lastname.like('%${filters['lastname']}%'));
      }
    }
    return whereClauses;
  }


  Future<int> getUserCount({Map<String, String>? filters}) async {
    final query = _database.selectOnly(_database.userTable)..addColumns([_database.userTable.id.count()]);
    if (filters != null && filters.isNotEmpty) {
      final List<Expression<bool>> whereClauses = getfilter(filters); // Directly call getfilter
      print("************whereClauses*******$whereClauses***");
      print(whereClauses.reduce((a, b) => a & b));
      
      if (whereClauses.isNotEmpty) {
        query.where(whereClauses.reduce((a, b) => a & b));
      }
    }
    final result = await query.getSingle();
    return result.read(_database.userTable.id.count()) ?? 0;
  }

  // Get paginated users
  // Get paginated users
  Future<List<UserWithRolesModel>> getPaginatedUsers({
    required int page,
    required int pageSize,
    Map<String, String>? filters,
  }) async {
    final offset = page * pageSize;
    print("Offset: $offset");
    print("Page size: $pageSize");
    print("Page: $page");

    // 1. Fetch users with pagination
    final userQuery = (_database.select(_database.userTable)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(pageSize, offset: offset));

    if (filters != null && filters.isNotEmpty) {
      final List<Expression<bool>> whereClauses = getfilter(filters); // Directly call getfilter
      if (whereClauses.isNotEmpty) {
        userQuery.where((tbl) => whereClauses.reduce((a, b) => a & b)); // Corrected line
      }
    }

    final users = await userQuery.get();
    if (users.isEmpty) {
      return [];
    }

    // 2. Fetch roles for the retrieved users in a single query
    final userIds = users.map((user) => user.id).toList();
    final rolesQuery = (_database.select(_database.userRoleTable)
          ..where((tbl) => tbl.userId.isIn(userIds)))
        .join([
          innerJoin(_database.roleTable,
              _database.userRoleTable.roleId.equalsExp(_database.roleTable.id)),
        ]);

    final roleResults = await rolesQuery.get();

    // 3. Combine the results
    final Map<int, UserWithRolesModel> userMap = {};
    for (final user in users) {
      userMap[user.id] = UserWithRolesModel(
          id: user.id,
          username: user.username,
          email: user.email,
          firstname: user.firstname,
          lastname: user.lastname,
          lastLogin: user.lastLogin,
          isSuperuser: user.isSuperuser,
          isStaff: user.isStaff,
          isActive: user.isActive,
          dateJoined: user.dateJoined,
          phoneNumber: user.phoneNumber,
          isDeleted: user.isDeleted,
          roles: []
        );
    }

    for (final row in roleResults) {
      final userId = row.readTable(_database.userRoleTable).userId;
      final role = row.readTable(_database.roleTable);
      if (userMap.containsKey(userId)) {
        userMap[userId]!.roles.add(RoleModel(id: role.id, name: role.name));
      }
    }

    return userMap.values.toList();
  }

  Future<int> insertUser({
    required String username,
    required String email,
    required String password,
    String? firstname,
    String? lastname,
    String? phoneNumber,
    bool? isSuperuser = false,
    bool? isStaff = false,
    bool? isActive = true,
    required int roleId,
  }) async {
    return _database.transaction<int>(() async {
      String salt = _generateSalt();
      String hashedPassword = _hashPassword(password, salt);
      int newUserId = await _database.into(_database.userTable).insert(
        UserTableCompanion.insert(
            username: Value(username),
            email: Value(email),
            password:Value(hashedPassword),
            lastname: Value(lastname),
            firstname: Value(firstname),
            phoneNumber: Value(phoneNumber),
            salt: Value(salt),
            isSuperuser: Value(isSuperuser ?? false),
            isStaff: Value(isStaff ?? false),
            isActive: Value(isActive ?? true),
            dateJoined: Value(DateTime.now()),

        ),
      );
      await insertUserRole(newUserId,roleId);
      return newUserId;
    });
  }
  Future<int> insertUserRole(int userId,int roleId) async {
    return await _database.into(_database.userRoleTable).insert(
      UserRoleTableCompanion.insert(userId: userId,roleId: roleId),
    );
  }

  Future<int> updateUser({
    required int userId,
    String? firstname,
    String? lastname,
    String? phoneNumber,
    bool? isActive = true,
    int? roleId,
  }) async {
    return _database.transaction<int>(() async {
      final updatedCompanion = UserTableCompanion(
        firstname: firstname != null ? Value(firstname) : const Value.absent(),
        lastname: lastname != null ? Value(lastname) : const Value.absent(),
        phoneNumber: phoneNumber != null ? Value(phoneNumber) : const Value.absent(),
        isActive: isActive != null ? Value(isActive) : const Value.absent(),
        // roleId will be handled in updateUserRole if provided
      );

      int result = await (_database.update(_database.userTable)
            ..where((t) => t.id.equals(userId)))
          .write(updatedCompanion);

      if (roleId != null) {
        await updateUserRole(userId, roleId);
      }

      return result;
    });
  }
  Future<int> updateUserRole(int userId,int roleId) async {
    return _database.transaction<int>(() async {
      return await (_database.update(_database.userRoleTable)..where((t) => t.userId.equals(userId))).write(
        UserRoleTableCompanion(
          roleId: Value(roleId),
        ),
      );
    });
     
  }
  Future<int> deleteUser(int userId) async {
    return await (_database.delete(_database.userTable)..where((t) => t.id.equals(userId))).go();
  }

  Future<List<RoleModel>> getAllRoles() async {
    final query = _database.select(_database.roleTable);
    final queryResult = await query.get();
    return queryResult.map((e) => RoleModel(id: e.id, name: e.name)).toList();
  }
  
  Future<RoleTableData?> getRole(String name) async {
    final query = _database.select(_database.roleTable);
    query.where((t) => t.name.equals(name)); // Removed the reassignment
    return await query.getSingleOrNull();
  }

  Future<UserTableData?> findUserByUsername(String username) async {
    final query = _database.select(_database.userTable)
      ..where((t) => t.username.equals(username));
    return await query.getSingleOrNull();
  }

  Future<bool> validatePassword(String username, String password) async {
    final user = await findUserByUsername(username);
    if (user == null) {
      return false;
    }
    final hashedPassword = _hashPassword(password, user.salt ?? '');
    return hashedPassword == user.password;
  }

  // // --- Password Encryption and Salt Generation ---

  String _generateSalt([int length = 32]) {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  String _hashPassword(String password, String salt) {
    final bytes = utf8.encode('$password$salt');
    final digest = sha256.convert(bytes);
    return base64Encode(digest.bytes);
  }
}