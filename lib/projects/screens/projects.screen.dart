import 'package:flutter/material.dart';
import 'package:todo_list/projects/components/project-card.dart';
import 'package:todo_list/projects/models/project.model.dart';
import 'package:todo_list/projects/repositories/projects.repositories.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('My projects')),
        body: FutureBuilder<List<ProjectModel>>(
          future: ProjectsRepository().getProjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Your projects list is empty',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              );
            }

            final projectsList = snapshot.data;

            return RefreshIndicator(
              onRefresh: () => ProjectsRepository().getProjects(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: projectsList!.length,
                itemBuilder: (context, index) => ProjectCard(
                  projectName: projectsList[index].name,
                  firstLetter: projectsList[index].name[0],
                  imgUrl: projectsList[index].imageUrl,
                  id: projectsList[index].id.toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
