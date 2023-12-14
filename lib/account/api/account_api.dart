import 'package:todo_list/account/models/user_model.dart';

import '../../service/request/request_service.dart';

class AccountApi {
  RequestsService api = RequestsService();

  Future getAccountReq() async {
    return api.get(
      '/account',
    );
  }

  Future updateAccountReq(Map<String, dynamic> payload) async {
    return api.patch('/account', data: payload);
  }
}
