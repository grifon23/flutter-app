import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/screens/sign-in.screen.dart';
import 'package:todo_list/auth/screens/sign_up.screen.dart';
import 'package:todo_list/projects/screens/project-detail.screen.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/navigation/routes-names.dart';
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
            print('TokenProvider ${context.read<TokenProvider>().token}', );
            if (tokenFromStorage != null) {
              return '/projects';
            }
            return null;
          },
          builder: (context, state) => SignInScreen(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => BottomBar(child: child),
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
              path: '/settings',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        )
      ],
    );
  }
}

class BottomBar extends StatefulWidget {
  BottomBar({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.go('/projects');
        break;
      case 1:
        context.go('/settings');
        break;
      default:
        context.go('/projects');
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        backgroundColor: const Color(0xffe0b9f6),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}
