import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/exercise_detail.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ExerciseDetailRepository{
  Future<List<ExerciseDetail>> getDetailExercise(int? exerciseId) async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/exercise_detail/get');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/exercise_detail/get?exerciseId="+exerciseId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((exerciseDetail) => ExerciseDetail.fromJson(exerciseDetail))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}