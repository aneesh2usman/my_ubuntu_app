import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/task_models.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<TaskModel> _tasks = [];
  late AppDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _database.taskDao.getAllTasksRowQuery();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _addTask(String title, int typeId) async {
    await _database.taskDao.insertTask(title, typeId);
    await _loadTasks();
  }

  Future<void> _deleteTask(int taskId) async {
    await _database.taskDao.deleteTask(taskId);
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Directly returning the Container
      child: Stack( // Using Stack to position the FAB
        children: [
          ListView.builder(
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
          Positioned( // Positioning the FloatingActionButton
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
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
          ),
        ],
      ),
    );
  }
}