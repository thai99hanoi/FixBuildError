import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class SymptomRepository{
  Future<List<Symptom>?> getAllSymptom() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/symptom/get-all');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/symptom/get-all"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(response.body);
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((symptom) => Symptom.fromJson(symptom))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}