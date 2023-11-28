import 'package:flutter/material.dart';
import 'package:todo_list/pages/home-page.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:todo_list/pages/project-detail.screen.dart';
import 'package:todo_list/pages/sign_up.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
            primary: Colors.grey.shade900, secondary: Colors.blue.shade500),
      ),
      title: 'Flutter Demo',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/homepage': (context) => const HomePage(),
        '/project-detail': (context) => ProjectDetailScreen(),
      },
    );
  }
}
