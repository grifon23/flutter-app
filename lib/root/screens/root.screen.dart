import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/screens/sign-in.screen.dart';
import 'package:todo_list/auth/screens/sign_up.screen.dart';
import 'package:todo_list/projects/screens/project-detail.screen.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/navigation/routes-names.dart';
import 'package:todo_list/root/screens/home.screen.dart';
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

            List<GoRoute> authStackNavGroup = [
              GoRoute(
                  name: AuthStack.SignIn,
                  path: '/signIn',
                  builder: (context, state) => SignInScreen()),
              GoRoute(
                  name: AuthStack.SignUp,
                  path: '/signUp',
                  builder: (context, state) => SignUpScreen()),
            ];

            List<GoRoute> userStackNavGroup = [
              GoRoute(
                  name: UserStack.Home,
                  path: '/home',
                  builder: (context, state) => HomeScreen()),
              GoRoute(
                  name: UserStack.Projects,
                  path: '/projects',
                  builder: ((context, state) => ProjectsScreen())),
              GoRoute(
                  name: UserStack.ProjectDetail,
                  path: '/project-detail/:id',
                  builder: (context, state) => ProjectDetailScreen(
                      projectId: state.pathParameters['id'],
                      projectName: state.uri.queryParameters['projectName'])),
              GoRoute(
                  path: '/settings',
                  builder: (context, state) => SettingsScreen()),
            ];

            GoRouter routers = GoRouter(
                initialLocation: '/signIn',
                redirect: (context, state) {
                  if (tokenFromStorage != null) {
                    return '/home';
                  }

                  if (tokenProvider.token != null) {
                    return '/home';
                  } else {
                    return '/signIn';
                  }
                },
                routes: [...authStackNavGroup, ...userStackNavGroup]);

            return MaterialApp.router(
              routerConfig: routers,
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
