import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/account/models/user_model.dart';
import 'package:todo_list/account/services/account_service.dart';
part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required this.accountService}) : super(AccountInitial()) {
    on<LoadAccount>((event, emit) async {
      try {
        emit(AccountLoading());
        final user = await accountService.loadAcount();
        emit(AccountLoaded(user: user));
      } catch (e) {
        print('error in Bloc $e');
        emit(AccountLoadingFailure(exeption: e));
      }
    });
    on<UpdateAccount>((event, emit) async {
      try {
        emit(AccountLoading());
        final user = await accountService.updateAccount(event.updatedUser);
        emit(AccountLoaded(user: user));
      } catch (e) {
        print('error in Bloc $e');
        emit(AccountLoadingFailure(exeption: e));
      }
    });
  }
  final AccountService accountService;
}
