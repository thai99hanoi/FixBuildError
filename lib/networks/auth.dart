import 'dart:async';
import 'dart:convert';

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/home_screen.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/ui/main_doctor.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/http_exception.dart';
import 'package:heath_care/utils/navigation_util.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  // ignore: non_constant_identifier_names

  var userRepository = UserRepository();
  var MainUrl = Api.authUrl;

  // ignore: non_constant_identifier_names

  var _token;
  var _userId;
  var _userEmail;
  var _expiryDate;
  var _authTimer;
  User? _currentUser;

  setCurrentUser(User user) {
    _currentUser = user;

    notifyListeners();
  }

  User? getCurrentUser() => _currentUser;

  Auth();

  Future<bool> get isAuth async {
    String? tokenTmp = await token;
    return tokenTmp != null && tokenTmp.isNotEmpty;
  }

  Future<String> get role async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? "";
  }

  Future<String?> get token async {
    if (_token == null) {
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
    try {
      await userRepository.updateUserOnline(0);
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
      NavigationUtil.pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (error) {
      print('Đăng xuất lỗi');
    }
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

    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    User user = await userRepository.getCurrentUser(tokenTmp: _token);
    setCurrentUser(user);
    // _userId = extractedUserData['userId'];
    // _userEmail = extractedUserData['userEmail'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autologout();

    return true;
  }

// ignore: non_constant_identifier_names
  Future<void> Authentication(User userLogin) async {
    DioCacheManager(CacheConfig(baseUrl: Api.authUrl)).clearAll();
    print('login');
    try {
      final url = '$MainUrl/anonymous/signin';

      final response = await http
          .post(Uri.parse(url),
              headers: {
                "content-type": "application/json",
                "accept": "application/json",
              },
              body: json.encode({
                'username': userLogin.username,
                'password': userLogin.password,
                // 'returnSecureToken': true
              }))
          .timeout(Duration(seconds: 10));

      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['data']['token'];

      User user = await userRepository.getCurrentUser(tokenTmp: _token);
      setCurrentUserCache(user.userId);
      setCurrentUser(user);
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
      await userRepository.updateUserOnline(1);
      String role = responseData['data']['roles'][0];
      prefs.setString('role', role);

      if (role == 'Bệnh nhân') {
        NavigationUtil.pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      } else if (role == 'Bác sĩ') {
        NavigationUtil.pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreenDoctor(),
          ),
        );
      } else {
        print('Đăng nhập lỗi');
      }
    } catch (e) {
      print(e.toString());
      print('Đăng nhập lỗi');
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

  Future<bool> setCurrentUserCache(int? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userId', value.toString());
  }

  Future<String> getCurrentUserCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? "";
  }

  Future<DateTime?> getExpiryDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateTime = prefs.getString('expiryDate');
    try {
      print(dateTime);
      return DateFormat("yyyy-MM-dd hh:mm:ss.SSSS").parse(dateTime ?? "");
    } catch (e) {
      return null;
    }
  }

  Future<void> login(User user) {
    return Authentication(user);
  }
}
