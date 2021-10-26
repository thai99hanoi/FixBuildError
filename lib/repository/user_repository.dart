import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';

class UserRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<User> getCurrentUser() async {
    final response = await apiBaseHelper.getWithCache("/v1/api/user/current-user");
    User _currentUser = User.fromJson(response['data']);
    return _currentUser;
  }

  Future<User?> getUserByUserName(String userName) async {
    try {
      Map<String, dynamic> response =
      await apiBaseHelper.getWithCache("/v1/api/user/$userName");
      return User.fromJson(response['data']);
    } on FetchDataException catch (e) {
      print(e);
    }
  }

  Future<List<User>?> getUserOnline() async {
    var user = await getCurrentUser();
    var userId = user.userId;
    print('Api Get, url /v1/api/user/users-online?userId="' + userId.toString());
    try {
      final response = await apiBaseHelper
          .get("/v1/api/user/users-online?userId=" + userId.toString());
      print('api get user online recieved!');
      final mapUsers = json.decode(response);
      return (mapUsers['data'] as List)
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