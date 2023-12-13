import 'package:flutter/material.dart';

import '../../service/request/request_service.dart';
import '../api/account_api.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountApi accountApi = AccountApi();

  void loadAccount() async {
    try {
      var resp = await accountApi.getAccountReq();
      print('account ${resp.data}');
    } catch (e) {
      print('Error in account: ${(e as DioErrorWrapper).errorMessage}');
    }
  }

  @override
  void initState() {
    loadAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('Account screen'),
      )),
    );
  }
}
