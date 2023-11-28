import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:todo_list/components/project-card/project-card.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> projects = [
      {'id': '1', 'name': 'Truth or Dare'},
      {'id': '2', 'name': 'Kruuu'},
      {'id': '3', 'name': 'Joy Job'},
      {'id': '4', 'name': 'Edu System'},
    ];
    final storage = new StorageService();

    var token = storage.getItem('accessToken');
    print(token);
    return Scaffold(
        appBar: AppBar(
          title: const Text('All projects'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => ProjectCard(
            projectName: projects[index]['name'],
            firstLetter: projects[index]['name'][0],
            id: projects[index]['id'],
          ),
          itemCount: projects.length,
        ));
  }
}
