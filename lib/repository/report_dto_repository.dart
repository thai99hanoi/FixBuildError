import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/daily_check_dto.dart';
import 'package:heath_care/model/list_report_dto.dart';
import 'package:heath_care/model/report.dart';
import 'package:heath_care/model/report_dto.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ReportDTORepository {
  Future<String> createReport(ReportDTO report) async {
    print('Api Post, url /v1/api/report/create');
    String token = await Auth().getToken();
    var user = await UserRepository().getCurrentUser();
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(Api.authUrl + "/v1/api/report/create"),
              headers: {
                "content-type": "application/json",
                'Authorization': 'Bearer $token',
              },
              body: json.encode({
                "username": user.username,
                "firstname": user.firstname,
                "lastname": user.lastname,
                "surname": user.surname,
                "oxygen": report.oxygen,
                "temperate": report.temperate,
                "symptomId": report.symptomId,
                "comment": report.comment,
                "exerciseId": report.exerciseId,
                "medicineId": report.medicineId
              }));
      responseJson = json.encode(response.body);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<ListReportDTO> getReportByUser(int userId) async {
    String? token = await Auth().getToken();
    print('Api Get, url  /v1/api/report/get-report');
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(Api.authUrl +
            "/v1/api/report/get-report?userId=" +
            userId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      ListReportDTO listReportDTO =
          ListReportDTO.fromJson(responseJson['data']);
      return listReportDTO;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<Report>> getReport(int userId) async {
    String? token = await Auth().getToken();
    print('Api Get, url  /v1/api/report/get/user');
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(Api.authUrl +
            "/v1/api/report/get/user?userId=" +
            userId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      print(responseJson);
      return (responseJson as List)
          .map((report) => Report.fromJson(report))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<DailyCheckDTO>> getTemperatureAndOxygen() async {
    String? token = await Auth().getToken();
    print('Api Get, url  /v1/api/daily-report/get-check');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/daily-report/get-check"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson as List)
          .map((report) => DailyCheckDTO.fromJson(report))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
