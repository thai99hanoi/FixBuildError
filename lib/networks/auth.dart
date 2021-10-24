import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:heath_care/utils/http_exception.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  // ignore: non_constant_identifier_names
  var MainUrl = Api.authUrl;

  // ignore: non_constant_identifier_names

  var _token;
  var _userId;
  var _userEmail;
  var _expiryDate;
  var _authTimer;
  Auth();
  bool get isAuth {
    // ignore: unnecessary_null_comparison
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return _token;
  }

  String get userId {
    return _userId;
  }

  String get userEmail {
    return _userEmail;
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    _userId = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void _autologout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timetoExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timetoExpiry), logout);
  }

  Future<bool> tryautoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(pref.getString('userData').toString()) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['date'].toString());
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    // _userId = extractedUserData['userId'];
    // _userEmail = extractedUserData['userEmail'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autologout();

    return true;
  }

  // ignore: non_constant_identifier_names
  Future<void> Authentication(User user) async {
    try {
      final url = '$MainUrl/authenticate';

      final response = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode({
            'username': user.username,
            'password': user.password,
            // 'returnSecureToken': true
          }));

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      // _userId = responseData['localId'];
      // _userEmail = responseData['email'];
      // final testDate = new DateFormat('dd-MM-yyyy HH:mm:ss');
      // DateTime exDate =testDate.parse(responseData['date']);
      // final format = new DateFormat('ss');
      // print(exDate);
      _expiryDate = DateTime.now().add(Duration(seconds: 600));

      _autologout();
      notifyListeners();
      Auth().setToken(_token);
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        // 'userId': _userId,
        // 'userEmail': _userEmail,
        'expiryDate': _expiryDate.toIso8601String(),
      });

      prefs.setString('userData', userData);

      print('check' + userData.toString());
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> login(User user) {
    return Authentication(user);
  }
}
