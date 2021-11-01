import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/covid_analysis.dart';
import 'package:heath_care/networks/api_base_helper.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class CovidAnalysisRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<CovidAnalysis> getCurrentPatients() async {
    print('Api Get, url https://static.pipezero.com/covid/data.json');
    try {
      final response = await http.get(
        Uri.parse("https://static.pipezero.com/covid/data.json"),
        headers: {
          "content-type": "application/json; charset=utf-8",
        },
      ).timeout(Duration(seconds: 20));
      final todayPatients = json.decode(response.body);
      CovidAnalysis data =
          CovidAnalysis.fromJson(todayPatients['total']['internal']);
      return data;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<CovidAnalysis> getTodayPatients() async {
    print('Api Get, url https://static.pipezero.com/covid/data.json');
    try {
      final response = await http.get(
        Uri.parse("https://static.pipezero.com/covid/data.json"),
        headers: {
          "content-type": "application/json; charset=utf-8",
        },
      ).timeout(Duration(seconds: 20));
      final todayPatients = json.decode(response.body);
      CovidAnalysis data =
          CovidAnalysis.fromJson(todayPatients['today']['internal']);
      return data;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
