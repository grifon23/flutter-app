import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/screens/my_app.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TokenProvider())],
      child: MyApp()));
}
