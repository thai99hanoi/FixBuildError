import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/doctor_by_patient_dto.dart';
import 'package:heath_care/model/patient_dto.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<User> getCurrentUser({String? tokenTmp}) async {
    final response = await apiBaseHelper
        .getWithCache("/v1/api/user/current-user", tokenTmp: tokenTmp);
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
    print(
        'Api Get, url /v1/api/user/users-online?userId="' + userId.toString());
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

  Future<void> updateUserOnline(int isOnline) async {
    var user = await getCurrentUser();
    print('Api Post, url /v1/api/user/update');
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
                "username": user.username,
                "mail": user.email,
                "phone": user.phone,
                "lastLogin": DateTime.now().toString(),
                "firstname": user.firstname,
                "lastname": user.lastname,
                "surname": user.surname,
                "avatar": user.avatar,
                "isOnline": isOnline,
                "isActive": user.isActive
              }));
      responseJson = json.encode(response.body);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<List<PatientDTO>?> getPatientByDoctor() async {
    String? token = await Auth().getToken();
    print('Api Get, url v1/api/patient-doctor/get-patient');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "v1/api/patient-doctor/get-patient"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print('api get user online recieved!');
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      return (responseJson['data'] as List)
          .map((user) => PatientDTO.fromJson(user))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<DoctorByPatientDTO> getDoctorByPatient() async {
    print('Api Get, url v1/api/patient-doctor/get-doctor');
    String? token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "v1/api/patient-doctor/get-doctor"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print('api get user online recieved!');
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      DoctorByPatientDTO doctorByPatientDTO = DoctorByPatientDTO.fromJson(responseJson['data']);
      return doctorByPatientDTO;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
