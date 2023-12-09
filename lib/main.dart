import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/screens/root.screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TokenProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Root(),
    );
  }
}
