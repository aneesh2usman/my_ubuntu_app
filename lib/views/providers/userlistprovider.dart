import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';
import 'package:my_ubuntu_app/views/providers/paginationprovider.dart';

class UserListProvider extends PaginationProvider<UserWithRolesModel> {
  final AppDatabase _database = AppDatabase();
  List<RoleModel> roles = [];

  UserListProvider() : super() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await getAllRoles();
    await loadPage(1); // Initial load using the generic loadPage
  }

  @override
  Future<int> getTotalItemCount() async {
    return _database.userDao.getUserCount();
  }

  @override
  Future<List<UserWithRolesModel>> getPaginatedItems(int page, int pageSize) async {
    return _database.userDao.getPaginatedUsers(page: page, pageSize: pageSize);
  }

  Future<void> addUser(
    {
      required String username,
      required String email,
      required String password,
      String? firstname,
      String? lastname,
      String? phoneNumber,
      required int roleId,
    }
  ) async {
    await _database.userDao.insertUser(
      username: username,
      email: email,
      password: password,
      firstname: firstname,
      lastname: lastname,
      phoneNumber: phoneNumber,
      roleId: roleId
    );
    await loadPage(1); // Reload the first page after adding
  }

  Future<void> updateUser({
    required int index,
    required int userId,
    String? firstname,
    String? lastname,
    String? phoneNumber,
    bool? isActive = true,
    int? roleId,
  }) async {
    await _database.userDao.updateUser(
      userId: userId,
      firstname: firstname,
      lastname: lastname,
      phoneNumber: phoneNumber,
      isActive: isActive,
      roleId: roleId,
    );
    final roleData = roles.firstWhere(
      (role) => role.id == roleId,
    );
    items[index] = items[index].copyWith(
      firstname: firstname,
      lastname: lastname,
      phoneNumber: phoneNumber,
      isActive: isActive,
      roles: [roleData],
    );
    notifyListeners();
  }

  Future<void> deleteUser(int userId) async {
    await _database.userDao.deleteUser(userId);
    await reloadCurrentPage();
  }

  Future<List<RoleModel>> getAllRoles() async {
    roles = await _database.userDao.getAllRoles();
    return roles;
  }
}