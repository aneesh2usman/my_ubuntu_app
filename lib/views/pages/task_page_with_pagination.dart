import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/task_models.dart';

class TaskListPagination extends StatefulWidget {
  const TaskListPagination({super.key});

  @override
  State<TaskListPagination> createState() => _TaskListPaginationState();
}

class _TaskListPaginationState extends State<TaskListPagination> {
  List<TaskModel> _tasks = [];
  late AppDatabase _database;
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  final int _itemsPerPage = 10;
  
  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _loadPage(_currentPage);
  }

  Future<void> _loadPage(int page) async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      // Get total count first to calculate pages
      final count = await _database.taskDao.getTaskCount();
      print("Total count: $count");
      _totalPages = (count / _itemsPerPage).ceil();
      print("Total pages: $_totalPages");
      
      // Adjust to valid page if needed
      if (page < 1) page = 1;
      if (page > _totalPages && _totalPages > 0) page = _totalPages;
      
      print("Selected page: $page");

      // Load the selected page
      final tasks = await _database.taskDao.getPaginatedTasks(
        page: page - 1,  // Convert to 0-based for the database
        pageSize: _itemsPerPage
      );
      
      setState(() {
        _tasks = tasks;
        _currentPage = page;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading tasks: $e');
    }
  }

  Future<void> _reloadCurrentPage() async {
    await _loadPage(_currentPage);
  }

  Future<void> _nextPage() async {
    if (_currentPage < _totalPages) {
      await _loadPage(_currentPage + 1);
    }
  }

  Future<void> _prevPage() async {
    if (_currentPage > 1) {
      await _loadPage(_currentPage - 1);
    }
  }

  Future<void> _firstPage() async {
    await _loadPage(1);
  }

  Future<void> _lastPage() async {
    await _loadPage(_totalPages);
  }

  Future<void> _addTask(String title, int typeId) async {
    await _database.taskDao.insertTask(title, typeId);
    await _loadPage(1); // Go back to first page after adding
  }

  Future<void> _deleteTask(int taskId) async {
    await _database.taskDao.deleteTask(taskId);
    await _reloadCurrentPage(); // Reload current page after deleting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadCurrentPage,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isLoading)
            const LinearProgressIndicator(minHeight: 4),
          
          
          
          // Task list
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('No tasks found'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text(
                            '${task.type.typeName} - ${task.attendant.map((a) => a.name).join(", ")}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTask(task.id!),
                        ),
                      );
                    },
                  ),
          ),
          // Pagination controls
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: ${_totalPages * _itemsPerPage} tasks'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.first_page),
                      onPressed: _currentPage > 1 ? _firstPage : null,
                      tooltip: 'First page',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _currentPage > 1 ? _prevPage : null,
                      tooltip: 'Previous page',
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Page $_currentPage of $_totalPages'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _currentPage < _totalPages ? _nextPage : null,
                      tooltip: 'Next page',
                    ),
                    IconButton(
                      icon: const Icon(Icons.last_page),
                      onPressed: _currentPage < _totalPages ? _lastPage : null,
                      tooltip: 'Last page',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController titleController = TextEditingController();
              return AlertDialog(
                title: const Text('Add New Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Task Title'),
                    ),
                    // Add UI for selecting task type here
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        _addTask(titleController.text, 1); // Assuming type ID 1
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}