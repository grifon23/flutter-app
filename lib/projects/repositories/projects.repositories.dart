import 'package:todo_list/service/request/request_service.dart';

class ProjectsRepository {
  RequestsService api = RequestsService();

  Future getProjects() async {
    return await api.get('/projects');
  }
}
