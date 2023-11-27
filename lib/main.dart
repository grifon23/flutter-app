import 'package:flutter/material.dart';
import 'package:todo_list/pages/home-page.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:todo_list/pages/project-detail.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/project-detail': (context) => ProjectDetailScreen(),
      },
    );
  }
}
