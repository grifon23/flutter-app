import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, this.projectId, this.name});

  final String? projectId;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name!),
        ),
        body: Center(child: Text('Project id: $projectId')));
  }
}
