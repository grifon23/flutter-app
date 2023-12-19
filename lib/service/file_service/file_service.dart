import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/account/api/account_api.dart';

class Params {
  String? filename;
  String? mimetype;
  int? userId;

  Params({this.filename, this.mimetype, this.userId});

  Map<String, dynamic> toMap() {
    return {'filename': filename, 'mimetype': mimetype, 'userId': userId};
  }
}

class FileService {
  Dio dio = Dio();
  Future upload(
    ParamsFile params,
    XFile file,
    getUrlReq,
    finishReq,
  ) async {
    final response = await getUrlReq(params);
    final presignedUrl = response.data['presignedUrl'];
    final uploadId = response.data['uploadId'];

    await uploadFile(presignedUrl, file, params.mimetype);
    return await finishReq(uploadId);
  }

  Future<void> uploadFile(
    String url,
    dynamic file,
    String mimetype,
  ) async {
    Uint8List image = File(file.path).readAsBytesSync();

    Options options = Options(
        contentType: mimetype,
        headers: {'Content-Length': image.length, 'Content-type': mimetype});

    await dio.put(url, data: file.openRead(), options: options);
  }
}
