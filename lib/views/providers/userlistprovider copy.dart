import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';
import 'package:provider/provider.dart';

// Data Provider
class UserListProvider extends ChangeNotifier {
  final AppDatabase _database = AppDatabase();
  List<UserWithRolesModel> _users = [];
  List<RoleModel> roles = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  final int itemsPerPage = 15;

  List<UserWithRolesModel> get users => _users;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  UserListProvider() {
    init();
  }
  Future<void> init() async {
    await getAllRoles();
    loadPage(1);
  }

  Future<void> loadPage(int page) async {
    if (_isLoading) return;

    _setLoading(true);

    try {
      
      final count = await _database.userDao.getUserCount();
      _totalPages = (count / itemsPerPage).ceil();

      if (page < 1) page = 1;
      if (page > _totalPages && _totalPages > 0) page = _totalPages;

      final users = await _database.userDao.getPaginatedUsers(
        page: page - 1,
        pageSize: itemsPerPage,
      );

      _users = users;
      _currentPage = page;
    } catch (e) {
      print('Error loading users: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> reloadCurrentPage() async {
    await loadPage(_currentPage);
  }

  Future<void> nextPage() async {
    if (_currentPage < _totalPages) {
      await loadPage(_currentPage + 1);
    }
  }

  Future<void> prevPage() async {
    if (_currentPage > 1) {
      await loadPage(_currentPage - 1);
    }
  }

  Future<void> firstPage() async {
    await loadPage(1);
  }

  Future<void> lastPage() async {
    await loadPage(_totalPages);
  }

  Future<void> addUser(String name,int roleId) async {
    final userId = await _database.userDao.insertUser(name);
    await _database.userDao.insertUserRole(userId,roleId);
    await loadPage(1);
  }

  Future<void> updateUser(int index ,int userId ,String name,int roleId) async {
    await _database.userDao.updateUser(userId,name);
    // 2. Update the local list ONLY if the database update was successful

    final roleData = roles.firstWhere(
      (role) => role.id == roleId,
    );
   
    _users[index] = _users[index].copyWith(name: name, roles: [roleData]);  
    notifyListeners(); // If this method is in your ChangeNotifier/Provider
     
  }

  Future<void> deleteUser(int userId) async {
    await _database.userDao.deleteUser(userId);
    await reloadCurrentPage();
  }

  Future <List<RoleModel>> getAllRoles() async {
    roles =  await _database.userDao.getAllRoles();
    return roles;
  }

 

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}