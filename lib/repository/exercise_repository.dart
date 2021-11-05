import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/exercise.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ExerciseRepository {
  Future<List<Exercise>?> getAllExercises() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/exercise/get-all');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/exercise/get-all"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<Exercise> getExerciseById(int exerciseId) async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/exercise/get');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/exercise/get?exerciseId="+exerciseId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      Exercise exe = Exercise.fromJson(responseJson['data']);
      return exe;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
