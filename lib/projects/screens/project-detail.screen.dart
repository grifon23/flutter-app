import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/root/navigation/routes-names.dart';

class ProjectDetailScreen extends StatelessWidget {
  ProjectDetailScreen({super.key, this.projectId, this.projectName});

  String? projectId;
  String? projectName;

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Dadaadada"),
        ),
        body: Column(children: [
          Center(child: Text('Project id: $projectId')),
          SizedBox(height: 20),
          Center(child: Text('Project name: $projectName')),
          SizedBox(height: 100),
          ElevatedButton(
              onPressed: () {
                context.goNamed(UserStack.Home);
              },
              child: Text('Go Back'))
        ]),
      ));
}
