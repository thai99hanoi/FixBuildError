import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';

class UserRepository{
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  Future<User> getCurrentUser() async {
    Map<String, dynamic> response = await apiBaseHelper.get("/api/v1/current-user");
    var entriesList = response.entries.toList();
    return User.fromMap(entriesList[1].value);
  }

  Future<List<User>?> getUserOnline() async {
    var user = await UserRepository().getCurrentUser();
    var userId = user.userId;
    Map<String, dynamic> response = await apiBaseHelper.get("/api/v1/users-online"+userId.toString());
    var entriesList = response.entries.toList();
    return parseUser(entriesList[1].value);
  }

  List<User>? parseUser(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromMap(json)).toList();
  }


}