import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/navigation/routes.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TokenProvider>(
        builder: (context, tokenProvider, child) => FutureBuilder(
          future: StorageService().getItem('accessToken'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var tokenFromStorage = snapshot.data;

              final GoRouter appRouter = AppRouter.createRouter(
                tokenFromStorage: tokenFromStorage,
              );

              return MaterialApp.router(
                routerConfig: appRouter,
                title: 'Flutter Demo',
              );
            }
          },
        ),
      );
}
