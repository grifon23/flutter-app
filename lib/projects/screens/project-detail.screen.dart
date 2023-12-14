import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatelessWidget {
  ProjectDetailScreen({super.key, this.projectId, this.projectName});

  String? projectId;
  String? projectName;

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text("$projectName"),
        ),
        body: Column(children: [
          Center(child: Text('Project id: $projectId')),
          SizedBox(height: 20),
          Center(child: Text('Project name: $projectName')),
          SizedBox(height: 100),
        ]),
      ));
}
