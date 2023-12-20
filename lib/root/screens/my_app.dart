import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/account/services/account_service.dart';
import 'package:todo_list/providers/token.provider.dart';
import 'package:todo_list/root/navigation/routes.dart';
import 'package:todo_list/service/local_storage/local_storage_service.dart';
import 'package:todo_list/store/account/reducer.dart';
import 'package:todo_list/store/state.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final store = Store<AppState>(reducer,
      initialState: AppState(counter: 0, text: '', user: null));

  getAccount() async {
    return await AccountService(store: store).loadAcount();
  }

  @override
  Widget build(BuildContext context) => Consumer<TokenProvider>(
        builder: (context, tokenProvider, child) => FutureBuilder(
          future: StorageService().getItem('accessToken'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var tokenFromStorage = snapshot.data;
              getAccount();
              final GoRouter appRouter = AppRouter.createRouter(
                tokenFromStorage: tokenFromStorage,
              );

              return StoreProvider(
                store: store,
                child: MaterialApp.router(
                  routerConfig: appRouter,
                  title: 'Flutter Demo',
                ),
              );
            }
          },
        ),
      );
}
