import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/screens/sign-in.screen.dart';
import 'package:todo_list/auth/screens/sign_up.screen.dart';
import 'package:todo_list/projects/screens/project-detail.screen.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/navigation/routes-names.dart';
import 'package:todo_list/root/navigation/routes.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';
import 'package:todo_list/settings/screens/settings.screen.dart';

class Root extends StatelessWidget {
  Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TokenProvider>(builder: (context, tokenProvider, child) {
      context.watch<TokenProvider>().token;

      return FutureBuilder(
        future: StorageService().getItem('accessToken'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var tokenFromStorage = snapshot.data;

            final GoRouter appRouter = AppRouter.createRouter(
              tokenFromStorage: tokenFromStorage,
            );

            return MaterialApp.router(
              routerConfig: appRouter,
              theme: ThemeData(
                colorScheme: ColorScheme.light(
                    primary: Colors.grey.shade900,
                    secondary: Colors.blue.shade500),
              ),
              title: 'Flutter Demo',
            );
          }
        },
      );
    });
  }
}
