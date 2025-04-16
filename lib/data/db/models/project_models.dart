
import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final int id;
  final String projectName;

  const ProjectModel({
    required this.id,
    required this.projectName,
  });

  ProjectModel copyWith({
    int? id,
    String? title,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      projectName: projectName ?? this.projectName,
    );
  }

  @override
  List<Object> get props => [id, projectName];
}
