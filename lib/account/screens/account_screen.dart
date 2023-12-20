import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/root/navigation/routes_names.dart';
import 'package:todo_list/store/state.dart';

import '../components/preview_account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   ModalRoute.of(context)?.isCurrent;

  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) => Stack(
          children: [
            vm.user == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PreviewAccount(user: vm.user as UserModel),
            Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  context.goNamed(UserStack.EditAccount);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
