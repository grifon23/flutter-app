import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/root/navigation/routes-names.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class ProjectCard extends StatelessWidget {
  final String projectName;
  final String firstLetter;
  final String id;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.firstLetter,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.goNamed(UserStack.ProjectDetail,
          pathParameters: {'id': id},
          queryParameters: {'projectName': projectName}),
      title: Text(
        projectName,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      leading: CircleAvatar(
        radius: 40.0,
        backgroundColor: Colors.yellowAccent,
        child: Text(
          firstLetter,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_outlined,
        size: 24,
      ),
    );
  }
}
