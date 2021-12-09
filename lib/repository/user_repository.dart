import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/doctor_by_patient_dto.dart';
import 'package:heath_care/model/password_dto.dart';
import 'package:heath_care/model/patient_dto.dart';
import 'package:heath_care/model/reset_password.dart';
import 'package:heath_care/model/send_otp_request.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<User> getCurrentUser({String? tokenTmp}) async {
    final response = await apiBaseHelper
        .getWithCache("/v1/api/user/v2/current-user", tokenTmp: tokenTmp);
    User _currentUser = User.fromJson(response);
    return _currentUser;
  }

  Future<User> getCurrentUserWithoutCache() async {
    String token = await Auth().getToken();
    print('Api Get, url /v1/api/user/v2/current-user');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/user/v2/current-user"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print('api get user online recieved!');
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      User _currentUser = User.fromJson(responseJson);
      return _currentUser ;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<User?> getUserByUserId(int? userId) async {
    try {
      Map<String, dynamic> response = await apiBaseHelper
          .getWithCache("/v1/api/user/get-by-id?userId=" + userId.toString());
      return User.fromJson(response['data']);
    } on FetchDataException catch (e) {
      print(e);
    }
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


  List<User>? parseUser(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<void> updateUserOffline() async {
    User user = await getCurrentUserWithoutCache();
    String token = await Auth().getToken();
    print('Api Post, url /v1/api/user/update');
    final f = new DateFormat('yyyy-MM-dd hh:mm:ss');
    var responseJson;
    try {
      final response =
      await http.post(Uri.parse(Api.authUrl + "/v1/api/user/update"),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "userId": user.userId,
            "username": user.username,
            "mail": user.email,
            "phone": user.phone,
            "identityCard": user.identityId,
            "lastLogin": f.format(DateTime.now()),
            "firstname": user.firstname,
            "lastname": user.lastname,
            "surname": user.surname,
            "avatar": user.avatar,
            "gender": user.gender,
            "address": user.address,
            "dob": f.format(user.dateOfBirth!),
            "isOnline": 0,
            "isActive": user.isActive
          }));
      responseJson = json.encode(utf8.decode(response.bodyBytes));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<void> updateUserOnline({String? tokenTmp}) async {
    User user = await getCurrentUser();
    print('Api Post, url /v1/api/user/update');
    final f = new DateFormat('yyyy-MM-dd hh:mm:ss');
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(Api.authUrl + "/v1/api/user/update"),
              headers: {
                "content-type": "application/json",
                'Authorization': 'Bearer $tokenTmp',
              },
              body: json.encode({
                "userId": user.userId,
                "username": user.username,
                "mail": user.email,
                "phone": user.phone,
                "identityCard": user.identityId,
                "lastLogin": f.format(DateTime.now()),
                "firstname": user.firstname,
                "lastname": user.lastname,
                "surname": user.surname,
                "avatar": user.avatar,
                "gender": user.gender,
                "address": user.address,
                "dob": f.format(user.dateOfBirth!),
                "isOnline": 1,
                "isActive": user.isActive
              }));
      responseJson = json.encode(utf8.decode(response.bodyBytes));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }
  Future<String> updateUser(User user) async {
    print('Api Post, url /v1/api/user/update');
    final f = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String token = await Auth().getToken();
    var responseJson;
    try {
      final response =
      await http.post(Uri.parse(Api.authUrl + "/v1/api/user/update"),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "userId": user.userId,
            "username": user.username,
            "mail": user.email,
            "phone": user.phone,
            "firstname": user.firstname,
            "lastLogin": f.format(user.lastLogin!),
            "lastname": user.lastname,
            "surname": user.surname,
            "identityCard": user.identityId,
            "dob": f.format(user.dateOfBirth!),
            "address": user.address,
            "gender": user.gender,
            "avatar": user.avatar,
            "isOnline": user.isOnline,
            "isActive": user.isActive
          }));
      responseJson = json.encode(utf8.decode(response.bodyBytes));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<List<User>?> getPatientByDoctor() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/patient-doctor/get-patient');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/patient-doctor/get-patient"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print('api get user online recieved!');
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      return (responseJson['data'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<User>?> getDoctorByPatient() async {
    User user = await getCurrentUser();
    print('Api Get, url /v1/api/patient-doctor/get-doctor');
    String? token = await Auth().getToken();
    List<User>? users;
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/patient-doctor/get-doctor?patientId="+user.userId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print('api get user online recieved!');
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      return (responseJson['data'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<String> changePassword(PasswordDTO passwordDTO) async {
    print('Api Post, url /v1/api/user/change-password');
    String token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(Api.authUrl + "/v1/api/user/change-password"),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "oldPassword": passwordDTO.oldPassword,
            "newPassword": passwordDTO.newPassword,
            "reEnterPassword": passwordDTO.reEnterPassword,
          }));
      responseJson = json.encode(response.body);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<String> sendOtpForgotPassword(SendOtpRequest sendMess) async {
    print('Api Post, url /v1/api/user/send-otp/forgot-password');
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(Api.authUrl + "/v1/api/user/send-otp/forgot-password"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode({
            "phone": sendMess.phone,
          }));
      responseJson = json.encode(response.body);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<String> verifyOtp(int otp) async {
    print('Api Post, url/send-otp/verify-otp/$otp');
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(Api.authUrl + "/v1/api/user/send-otp/verify/$otp"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          });
      responseJson = json.encode(response.body);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }



  Future<String> resetPassword(ResetPassword password, String token) async {
    print('Api Post, url /v1/api/user/reset-password/$token');
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(Api.authUrl + "/v1/api/user/reset-password/$token"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode({
            "password": password.password,
          }));
      responseJson = json.encode(response.body);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }
}
