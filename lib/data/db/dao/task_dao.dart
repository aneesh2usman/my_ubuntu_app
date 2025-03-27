// task_dao.dart

import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/task_models.dart';

class TaskDao {
  final AppDatabase _database;

  TaskDao(this._database);

  Future<List<TaskModel>> getAllTasks() async {
    final query = _database.select(_database.taskTable).join([
      innerJoin(_database.typeTable, _database.taskTable.type.equalsExp(_database.typeTable.id)),
      innerJoin(_database.attendantTable, _database.attendantTable.taskId.equalsExp(_database.taskTable.id)),
    ]);

    query.orderBy([OrderingTerm.desc(_database.taskTable.id)]);

    final queryResult = await query.get();

    final taskMap = <int, TaskModel>{};
    final attendantMap = <int, List<AttendantModel>>{};

    for (final row in queryResult) {
      print("################################################");
      final task = row.readTable(_database.taskTable);
      final type = row.readTable(_database.typeTable);
      final attendant = row.readTable(_database.attendantTable);


      final taskId = task.id;

      if (!taskMap.containsKey(taskId)) {
        taskMap[taskId] = TaskModel(
          id: taskId,
          title: task.title,
          type: TypeModel(id: type.id, typeName: type.typeName),
          attendant: [],
        );
        attendantMap[taskId] = [];
        
      }
      
      attendantMap[taskId]!.add(AttendantModel(id: attendant.id, name: attendant.name));
    }

    return taskMap.values.map((task) {
      return task.copyWith(attendant: attendantMap[task.id]!);
    }).toList();
  }

  Future<List<TaskModel>> getAllTasksRowQuery() async {
    // Define the raw SQL query with joins - using aliases to avoid column name conflicts
    final String rawQuery = '''
      SELECT 
        t.id AS t_id, 
        t.title AS t_title,
        ty.id AS ty_id, 
        ty.type_name AS ty_type_name,
        a.id AS a_id, 
        a.name AS a_name
      FROM 
        ${_database.taskTable.actualTableName} t
      INNER JOIN 
        ${_database.typeTable.actualTableName} ty ON t.type = ty.id
      INNER JOIN 
        ${_database.attendantTable.actualTableName} a ON a.task_id = t.id
      ORDER BY 
        t.id DESC
    ''';

    // Execute the raw query
    final queryResult = await _database.customSelect(
      rawQuery,
      readsFrom: {
        _database.taskTable,
        _database.typeTable,
        _database.attendantTable,
      },
    ).get();

    // Process results
    final taskMap = <int, TaskModel>{};
    final attendantMap = <int, List<AttendantModel>>{};

    for (final row in queryResult) {
      // Extract data from query result using the aliases we defined in the SQL
      final taskId = row.read<int>('t_id');
      final title = row.read<String>('t_title');
      final typeId = row.read<int>('ty_id');
      final typeName = row.read<String>('ty_type_name');
      final attendantId = row.read<int>('a_id');
      final attendantName = row.read<String>('a_name');
      
      if (!taskMap.containsKey(taskId)) {
        taskMap[taskId] = TaskModel(
          id: taskId,
          title: title,
          type: TypeModel(id: typeId, typeName: typeName),
          attendant: [],
        );
        attendantMap[taskId] = [];
      }
      
      attendantMap[taskId]!.add(AttendantModel(id: attendantId, name: attendantName));
    }
    
    final result = taskMap.values.map((task) {
      return task.copyWith(attendant: attendantMap[task.id]!);
    }).toList();
    return result;
  }


  Future<int> getTaskCount() async {
    final query = _database.selectOnly(_database.taskTable)
      ..addColumns([countAll()]);
    final result = await query.getSingle();
    return result.read(countAll()) ?? 0;
  }

  // Get paginated tasks
  Future<List<TaskModel>> getPaginatedTasks({required int page, required int pageSize}) async {
    final offset = page * pageSize;

    print("Offset: $offset");
    print("Page size: $pageSize");
    print("Page: $page");

    // Fetch tasks with type information
    final taskQuery = _database.select(_database.taskTable).join([
      innerJoin(_database.typeTable, _database.taskTable.type.equalsExp(_database.typeTable.id)),
    ])..orderBy([OrderingTerm.desc(_database.taskTable.id)])..limit(pageSize, offset: offset);

    print("Task Query: $taskQuery");

    final taskRowsWithType = await taskQuery.get();

    if (taskRowsWithType.isEmpty) {
      return [];
    }

    final taskMap = <int, TaskModel>{};
    final taskIds = <int>[];

    for (final row in taskRowsWithType) {
      final task = row.readTable(_database.taskTable);
      final type = row.readTable(_database.typeTable);
      final taskId = task.id;
      taskIds.add(taskId);
      taskMap[taskId] = TaskModel(
        id: taskId,
        title: task.title,
        type: TypeModel(id: type.id, typeName: type.typeName),
        attendant: [], // Initialize with an empty list
      );
    }

    print("Fetched Task IDs: $taskIds");

    // Prefetch attendants for the retrieved tasks in a single query
    final attendantQuery = _database.select(_database.attendantTable)
      ..where((tbl) => tbl.taskId.isIn(taskIds));

    print("Attendant Query: $attendantQuery");

    final attendantResults = await attendantQuery.get();

    // Group attendants by their taskId
    final attendantsByTaskId = <int, List<AttendantModel>>{};
    for (final attendantData in attendantResults) {
      final taskId = attendantData.taskId;
      if (!attendantsByTaskId.containsKey(taskId)) {
        attendantsByTaskId[taskId] = [];
      }
      attendantsByTaskId[taskId]!.add(AttendantModel(id: attendantData.id, name: attendantData.name));
    }

    print("Prefetched Attendants by Task ID: $attendantsByTaskId");

    // Merge the prefetched attendants into the TaskModel objects
    final paginatedTasks = taskMap.values.map((task) {
      return task.copyWith(attendant: attendantsByTaskId[task.id] ?? []);
    }).toList();

    print("Paginated Tasks with Attendants: ${paginatedTasks.length}");

    return paginatedTasks;
  }

  Future<int> insertTask(String taskTitle, int typeId) async {
    return _database.transaction<int>(() async {
      int newTaskId = await _database.into(_database.taskTable).insert(
        TaskTableCompanion.insert(title: taskTitle, type: typeId),
      );

      await _database.into(_database.attendantTable).insert(
        AttendantTableCompanion.insert(
          name: attendantMock.getRandomElement(),
          taskId: newTaskId,
        ),
      );
      await _database.into(_database.attendantTable).insert(
        AttendantTableCompanion.insert(
          name: attendantMock.getRandomElement(),
          taskId: newTaskId,
        ),
      );

      return newTaskId;
    });
  }
  Future<int> updateTask(int taskId, String newTitle,int typeId) async {
    return (_database.update(_database.taskTable)..where((t) => t.id.equals(taskId))).write(
      TaskTableCompanion(
        title: Value(newTitle),
        type: Value(typeId),
      ),
    );
  }
  Future<void> deleteTask(int taskId) async {
    print("*********taskId*****");
    print(taskId);
    await (_database.delete(_database.attendantTable)
          ..where((tbl) => tbl.taskId.equals(taskId)))
        .go();
    await (_database.delete(_database.taskTable)
          ..where((tbl) => tbl.id.equals(taskId)))
        .go();
  }

  Future<List<TypeModel>> getAllTypes() async {
    final query = _database.select(_database.typeTable);
    final queryResult = await query.get();
    return queryResult.map((e) => TypeModel(id: e.id, typeName: e.typeName)).toList();
  }
}