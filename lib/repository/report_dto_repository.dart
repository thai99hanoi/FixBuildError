import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/report_dto.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ReportDTORepository {
  Future<void> createReport(ReportDTO report) async {
    print('Api Post, url /v1/api/report/create');
    String token = await Auth().getToken();
    var user = await UserRepository().getCurrentUser();
    var responseJson;
    try {
      final response = await http.post(Uri.parse(Api.authUrl + "/v1/api/report/create"),
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
}