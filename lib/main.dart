import 'package:flutter/material.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/projects/screens/project-detail.screen.dart';
import 'package:todo_list/root/screens/home.screen.dart';
import 'package:todo_list/settings/screens/settings.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
      routes: {
        '/projects': (context) => const ProjectsScreen(),
        '/project-detail': (context) => ProjectDetailScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
