import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/task_models.dart';
import 'package:provider/provider.dart';

// Data Provider
class TaskListProvider extends ChangeNotifier {
  final AppDatabase _database = AppDatabase();
  List<TaskModel> _tasks = [];
  List<TypeModel> taskTypes = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  final int itemsPerPage = 10;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  TaskListProvider() {
    init();
  }
  Future<void> init() async {
    await getAllTypes();
    loadPage(1);
  }

  Future<void> loadPage(int page) async {
    if (_isLoading) return;

    _setLoading(true);

    try {
      
      final count = await _database.taskDao.getTaskCount();
      _totalPages = (count / itemsPerPage).ceil();

      if (page < 1) page = 1;
      if (page > _totalPages && _totalPages > 0) page = _totalPages;

      final tasks = await _database.taskDao.getPaginatedTasks(
        page: page - 1,
        pageSize: itemsPerPage,
      );

      _tasks = tasks;
      _currentPage = page;
    } catch (e) {
      print('Error loading tasks: $e');
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

  Future<void> addTask(String title, int typeId) async {
    await _database.taskDao.insertTask(title, typeId);
    await loadPage(1);
  }

  Future<void> updateTask(int index ,int taskId ,String title, int typeId ) async {
    await _database.taskDao.updateTask(taskId,title,typeId);
    // 2. Update the local list ONLY if the database update was successful
    await getAllTypes();
    final typeData = taskTypes.firstWhere(
      (type) => type.id == typeId,
    );
      
    _tasks[index] = _tasks[index].copyWith(title: title, type: typeData);
    notifyListeners(); // If this method is in your ChangeNotifier/Provider
     
  }

  Future<void> deleteTask(int taskId) async {
    await _database.taskDao.deleteTask(taskId);
    await reloadCurrentPage();
  }

  Future <List<TypeModel>> getAllTypes() async {
    taskTypes =  await _database.taskDao.getAllTypes();
    return taskTypes;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}