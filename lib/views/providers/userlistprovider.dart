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
  Future<int> getTotalItemCount({Map<String, String>? filters}) async {
    return _database.userDao.getUserCount(filters: filters);
  }

  @override
  Future<List<UserWithRolesModel>> getPaginatedItems(int page, int pageSize, {Map<String, String>? filters}) async {
    return _database.userDao.getPaginatedUsers(page: page, pageSize: pageSize,filters: filters);
  }
  @override
  bool isItemMatch(UserWithRolesModel item, Map<String, String> filters) {
    bool match = true;
    if (filters.containsKey('username')) {
      match = match && (item.username?.toLowerCase().contains(filters['username']!) ?? false);
    }
    if (filters.containsKey('email')) {
      match = match && (item.email?.toLowerCase().contains(filters['email']!) ?? false);
    }
    if (filters.containsKey('firstname')) {
      match = match && (item.firstname?.toLowerCase().contains(filters['firstname']!) ?? false);
    }
    if (filters.containsKey('lastname')) {
      match = match && (item.lastname?.toLowerCase().contains(filters['lastname']!) ?? false);
    }
    if (filters.containsKey('phoneNumber')) {
      match = match && (item.phoneNumber?.toLowerCase().contains(filters['phoneNumber']!) ?? false);
    }
    return match;
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

  @override
  Future<void> filterItems(Map<String, String> filters) async {
    setFiltering(filters.isNotEmpty);
    await loadPage(1); // Reset to the first page after filtering
  }

  // Convenience method for easier filtering from UI
  Future<void> filter({String? username, String? email, String? firstName, String? lastName, String? phone}) async {
    filter_data = {};
    if (username != null && username.isNotEmpty) {
      filter_data['username'] = username.toLowerCase();
    }
    if (email != null && email.isNotEmpty) {
      filter_data['email'] = email.toLowerCase();
    }
    if (firstName != null && firstName.isNotEmpty) {
      filter_data['firstname'] = firstName.toLowerCase();
    }
    if (lastName != null && lastName.isNotEmpty) {
      filter_data['lastname'] = lastName.toLowerCase();
    }
    if (phone != null && phone.isNotEmpty) {
      filter_data['phoneNumber'] = phone.toLowerCase();
    }
    await filterItems(filter_data);
  }
  Future<List<UserWithRolesModel>> fetchUsers(int pageKey, Map<String, String>? filters) async {
    return await _database.userDao.getPaginatedUsers(
      page: pageKey,
      pageSize: itemsPerPage,
      filters: filters,
    );
  }
}