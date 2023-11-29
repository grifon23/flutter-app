import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo_list/projects/screens/projects.screen.dart';
import 'package:todo_list/root/screens/root.screen.dart';
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
    const Root(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All projects'),
        ),
        body: userNavigatorTabs[currentIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              rippleColor: Colors.yellowAccent,
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
                GButton(icon: Icons.settings, text: 'Settings')
              ],
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
