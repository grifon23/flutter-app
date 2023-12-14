import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/navigation/routes-names.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Center(child: Text('Settings screen')),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            context.read<TokenProvider>().logout();
            context.goNamed(AuthStack.SignIn);
          },
          child: Text('drrgg'),
        ),
      ),
    );
  }
}
