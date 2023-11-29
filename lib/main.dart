import 'package:flutter/material.dart';
import 'package:todo_list/auth/screens/sign-in.screen.dart';
import 'package:todo_list/auth/screens/sign_up.screen.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.light(
            primary: Colors.grey.shade900, secondary: Colors.blue.shade500),
      ),
      title: 'Flutter Demo',
      home: SignInScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/project-detail': (context) => ProjectDetailScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
