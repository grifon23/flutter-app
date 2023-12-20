import 'dart:convert';

import 'package:todo_list/projects/models/project.model.dart';
import 'package:todo_list/service/request/request_service.dart';

class ProjectsRepository {
  RequestsService api = RequestsService();

  Future<List<ProjectModel>> getProjects() async {
    final response = await api.get('/projects');

    final List<dynamic> items = response.data['items'];

    final projects = items.map((it) {
      return ProjectModel(
        id: it['id'],
        imageUrl: it['imageUrl'],
        name: it['name'],
      );
    }).toList();

    return projects;
  }
}
