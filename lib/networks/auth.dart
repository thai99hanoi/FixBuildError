import 'dart:async';
import 'dart:convert';

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:heath_care/utils/http_exception.dart';
import 'package:intl/intl.dart';

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

  Future<bool> get isAuth async {
    String? tokenTmp = await token;
    return tokenTmp != null && tokenTmp.isNotEmpty;
  }

  Future<String?> get token async {
    if(_token == null){
      _token = await getToken();
    }
    _expiryDate = await getExpiryDate();
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
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
    DioCacheManager(CacheConfig(baseUrl: Api.authUrl)).clearAll();
  }

  void _autologout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timetoExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timetoExpiry), logout);
    DioCacheManager(CacheConfig(baseUrl: Api.authUrl)).clearAll();
  }

  Future<bool> tryautoLogin() async {
    print('tryLogin');
    DioCacheManager(CacheConfig(baseUrl: Api.authUrl)).clearAll();
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
    json.decode(pref.getString('userData') ?? "") as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['expiryDate'].toString());
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
    DioCacheManager(CacheConfig(baseUrl: Api.authUrl)).clearAll();
    print('login');
    try {
      final url = '$MainUrl/anonymous/signin';

      final response = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode({
            'username': user.username,
            'password': user.password,
            // 'returnSecureToken': true
          })).timeout(Duration(seconds: 10));;

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


      final userData = json.encode({
        'token': _token,
        // 'userId': _userId,
        // 'userEmail': _userEmail,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', userData);
      setToken(_token);
      setExpiryDate(_expiryDate.toString());
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> setExpiryDate(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('expiryDate', value);
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  Future<DateTime?> getExpiryDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateTime = prefs.getString('expiryDate');
    try{
      print(dateTime);
      return DateFormat("yyyy-MM-dd hh:mm:ss.SSSS").parse(dateTime??"");
    }catch(e){
      return null;
    }
  }

  Future<void> login(User user) {
    return Authentication(user);
  }
}