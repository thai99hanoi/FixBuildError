import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  Future<User> getCurrentUser() async {
    Map<String, dynamic> response =
        await apiBaseHelper.get("/api/v1/current-user");
    var entriesList = response.entries.toList();
    return User.fromMap(entriesList[1].value);
  }

  Future<List<User>?> getUserOnline() async {
    var user = await UserRepository().getCurrentUser();
    String token = await Auth().getToken();
    var userId = user.userId;
    print('Api Get, url /api/v1/users-online?userId="' + userId.toString());
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(
            Api.authUrl + "/api/v1/users-online?userId=" + userId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(response.body);
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  List<User>? parseUser(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
