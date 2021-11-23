import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/result.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ResultRepository {
  Future<List<Result>?> getAllResultByUserId(int? userId) async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/result/get-result');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl +
            "/v1/api/result/get-result?userId=" +
            userId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((result) => Result.fromJson(result))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<Result>?> getAllResultCurrentUserId() async {
    var _userID = await Auth().getCurrentUserCache();
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/result/get-result');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl +
            "/v1/api/result/get-result?userId=" +
            _userID.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((result) => Result.fromJson(result))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
