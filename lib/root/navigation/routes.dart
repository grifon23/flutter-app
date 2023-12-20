import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/account/screens/account_screen.dart';
import 'package:todo_list/account/screens/edit_account.dart';
import 'package:todo_list/auth/screens/sign-in.screen.dart';
import 'package:todo_list/auth/screens/sign_up.screen.dart';
import 'package:todo_list/projects/screens/project_detail.screen.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/root/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:todo_list/root/navigation/routes_names.dart';
import 'package:todo_list/settings/screens/settings.screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter createRouter({
    required dynamic tokenFromStorage,
  }) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: [
        GoRoute(
          name: AuthStack.SignIn,
          path: '/',
          routes: [
            GoRoute(
              name: AuthStack.SignUp,
              path: 'signUp',
              builder: (context, state) => SignUpScreen(),
            ),
          ],
          redirect: (context, state) {
            if (tokenFromStorage != null) {
              return '/projects';
            }
            return null;
          },
          builder: (context, state) => SignInScreen(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => BottomNavBar(child: child),
          routes: [
            GoRoute(
                name: UserStack.Projects,
                parentNavigatorKey: _shellNavigatorKey,
                path: '/projects',
                routes: [
                  GoRoute(
                      name: UserStack.ProjectDetail,
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'project-detail:id',
                      builder: (context, state) => ProjectDetailScreen(
                          projectId: state.pathParameters['id'],
                          projectName:
                              state.uri.queryParameters['projectName']))
                ],
                builder: ((context, state) => ProjectsScreen())),
            GoRoute(
              name: UserStack.Settings,
              path: '/settings',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const SettingsScreen(),
            ),
            GoRoute(
                name: UserStack.Account,
                path: '/${UserStack.Account}',
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) => const AccountScreen(),
                routes: [
                  GoRoute(
                    name: UserStack.EditAccount,
                    path: UserStack.EditAccount,
                    parentNavigatorKey: _shellNavigatorKey,
                    builder: (context, state) => const EditAccount(),
                  ),
                ]),
          ],
        )
      ],
    );
  }
}
