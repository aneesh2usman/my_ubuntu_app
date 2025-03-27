import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/models/task_models.dart';
import 'package:my_ubuntu_app/views/providers/tasklistprovider.dart';
import 'package:provider/provider.dart';

class TaskListPaginationwithProvider extends StatelessWidget {
  const TaskListPaginationwithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskListProvider(),
      child: _TaskListPaginationConsumer(),
    );
  }
}

class _TaskListPaginationConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     onPressed: taskProvider.reloadCurrentPage,
        //     tooltip: 'Refresh',
        //   ),
        // ],
      ),
      body: Column(
        children: [
          if (taskProvider.isLoading)
            const LinearProgressIndicator(minHeight: 4),
          Expanded(
            child: taskProvider.tasks.isEmpty
                ? const Center(child: Text('No tasks found'))
                : ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text(
                            '${task.type.typeName} - ${task.attendant.map((a) => a.name).join(", ")}'),
                        trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'delete') {
                            taskProvider.deleteTask(task.id!);
                          } else if (value == 'edit') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return EditTaskPopup(context, taskProvider, index);
                              },
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                      );
                    },
                  ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Total: ${taskProvider.totalPages * taskProvider.itemsPerPage} tasks'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.first_page),
                      onPressed: taskProvider.currentPage > 1
                          ? taskProvider.firstPage
                          : null,
                      tooltip: 'First page',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: taskProvider.currentPage > 1
                          ? taskProvider.prevPage
                          : null,
                      tooltip: 'Previous page',
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          'Page ${taskProvider.currentPage} of ${taskProvider.totalPages}'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed:
                          taskProvider.currentPage < taskProvider.totalPages
                              ? taskProvider.nextPage
                              : null,
                      tooltip: 'Next page',
                    ),
                    IconButton(
                      icon: const Icon(Icons.last_page),
                      onPressed:
                          taskProvider.currentPage < taskProvider.totalPages
                              ? taskProvider.lastPage
                              : null,
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
              return AddTaskPopup(context, taskProvider);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget AddTaskPopup(BuildContext context, TaskListProvider taskProvider) {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  int? selectedTypeId ; // Initialize with existing type ID
  return AlertDialog(
    title: const Text('Add New Task'),
    content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Task Title'),
            validator: (value) {
              print("*******value******$value*");
              if (value == null || value.isEmpty) {
                return 'Please enter a task title';
              }
              return null;
            },
         
            
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Task Type',
                border: OutlineInputBorder(),
              ),
              value: selectedTypeId,
              items: taskProvider.taskTypes.map((type) {
                return DropdownMenuItem<int>(
                  value: type.id,
                  child: Text(type.typeName),
                );
              }).toList(),
              onChanged: (value) {
                selectedTypeId = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Please enter a task type';
                }
                return null;
              },
          ),
          // Add UI for selecting task type here
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) { 
            if (titleController.text.isNotEmpty && selectedTypeId != null) {
              taskProvider.addTask(titleController.text, selectedTypeId!); // Assuming type ID 1
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Please fill in all fields.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
        child: const Text('Add'),
      ),
    ],
  );
}


Widget EditTaskPopup(BuildContext context, TaskListProvider taskProvider,index) {
  
  final TaskModel task = taskProvider.tasks[index];
  TextEditingController titleController = TextEditingController(text: task.title);
  int? selectedTypeId = task.type?.id; // Initialize with existing type ID
  return AlertDialog(
    title: const Text('Edit New Task'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Task Title'),
         
        ),
        SizedBox(height: 16),
        DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Task Type',
              border: OutlineInputBorder(),
            ),
            value: selectedTypeId,
            items: taskProvider.taskTypes.map((type) {
              return DropdownMenuItem<int>(
                value: type.id,
                child: Text(type.typeName),
              );
            }).toList(),
            onChanged: (value) {
              selectedTypeId = value;
            },
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
          if (titleController.text.isNotEmpty && selectedTypeId != null) {
            taskProvider.updateTask(index,taskProvider.tasks[index].id,titleController.text,selectedTypeId!);
            Navigator.pop(context);
          } else{
            AlertDialog(
              title: const Text('Error'),
              content: const Text('Please fill in all fields.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          }
        },
        child: const Text('Edit'),
      ),
    ],
  );
}