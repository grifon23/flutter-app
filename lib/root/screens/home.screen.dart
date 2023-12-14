import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/account/screens/account_screen.dart';
import 'package:todo_list/account/screens/edit_account.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';
import 'package:todo_list/settings/screens/settings.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final userNavigatorTabs = [
    const ProjectsScreen(),
    const SettingsScreen(),
    AccountScreen(),
    EditAccount()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All projects'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                context.read<TokenProvider>().logout();
              },
            )
          ],
        ),
        body: userNavigatorTabs[currentIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: GNav(
            tabMargin: EdgeInsets.all(8.0),
            rippleColor: Color.fromARGB(255, 80, 80, 19),
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.black,
            gap: 8,
            tabBackgroundColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
            selectedIndex: currentIndex,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Projects',
              ),
              GButton(icon: Icons.people, text: 'Peoples'),
              GButton(icon: Icons.account_circle, text: 'Account'),
              GButton(icon: Icons.edit, text: 'Edit')
            ],
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
