import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.go('/projects');
        break;
      case 1:
        context.go('/settings');
        break;
      case 2:
        context.go('/account');
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
    return SafeArea(
        child: Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: GNav(
          tabMargin: EdgeInsets.only(top: 16),
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
            GButton(icon: Icons.settings, text: 'Settings'),
            GButton(icon: Icons.account_circle, text: 'Account'),
          ],
          onTabChange: changeTab,
        ),
      ),
    ));
  }
}
