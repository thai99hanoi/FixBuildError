import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';

// import 'package:heath_care/networks/api_base_helper.dart';
// import 'package:http/http.dart';

class FileRepository {
  // ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<String?> uploadImage(String? path) async {
    if (path == null) return null;
    final dio = Dio();
    final token = await Auth().getToken();
    var formData = FormData();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      formData.files.add(MapEntry(
        "file",
        await MultipartFile.fromFile(path),
      ));
      var response =
          await Dio().post(Api.authUrl + '/v1/api/uploadFile', data: formData);
      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
