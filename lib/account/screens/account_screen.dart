import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/request/request_service.dart';
import '../bloc/account_bloc.dart';
import '../components/preview_account.dart';
import '../services/account_service.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final accountBloc = AccountBloc(accountService: AccountService());

  @override
  void initState() {
    accountBloc.add(LoadAccount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        if (state is AccountLoaded) {
          return SafeArea(
            child: PreviewAccount(user: state.user),
          );
        }
        if (state is AccountLoadingFailure) {
          final error = (state.exeption as DioErrorWrapper).errorMessage;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$error'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        accountBloc.add(LoadAccount());
                      },
                      child: const Text('Try again'),
                    )
                  ]),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
