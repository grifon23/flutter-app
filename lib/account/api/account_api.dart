import 'package:todo_list/service/file_service/file_service.dart';

import '../../service/request/request_service.dart';

class ParamsFile {
  final int userId;
  final String filename;
  final String mimetype;

  ParamsFile(
      {required this.userId, required this.filename, required this.mimetype});
  Map<String, dynamic> toMap() {
    return {'userId': userId, 'filename': filename, 'mimetype': mimetype};
  }
}

class AccountApi {
  RequestsService api = RequestsService();

  Future getAccountReq() async {
    return api.get('/account');
  }

  Future updateAccountReq(Map<String, dynamic> payload) async {
    return api.patch('/account', data: payload);
  }

  Future getAvatarLink(ParamsFile params) async {
    return api.get('/users/avatarUrl-link', params: params.toMap());
  }

  Future finishUploadReq(String uploadId) async {
    return api
        .put('/users/avatarUrl-finish-upload', data: {'uploadId': uploadId});
  }
}
