import '../../service/request/request_service.dart';

class AccountApi {
  RequestsService api = RequestsService();

  Future getAccountReq() async {
    return api.get(
      '/account',
    );
  }
}
