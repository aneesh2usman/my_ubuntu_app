// Project_dao.dart

import 'package:drift/drift.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/project_models.dart';

class ProjectDao {
  final AppDatabase _database;

  ProjectDao(this._database);

  

  Future<int> insertProject(String projectName, DateTime? createdAt) async {
    print("***************insertProject**********");
    print("Inserting project: $projectName");
    print("Date: $createdAt");
    try {
      
      return await _database.transaction<int>(() async {
        int newProjectId = await _database.into(_database.projectTable).insert(
          ProjectTableCompanion.insert(projectName: projectName, createdAt: Value(createdAt!)),
        );
        print("New project ID: $newProjectId");
        return newProjectId;
      });
    } catch (e) {
      print("Error inserting project: $e");
      // Consider re-throwing the error or handling it appropriately
      rethrow; // Or return a specific error code/value
    }
  }


}