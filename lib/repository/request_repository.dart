import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/request.dart';
import 'package:heath_care/model/request_dto.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;

class RequestRepository{
  Future<List<Request>> getAllRequest() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/request/get-all');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/request/get-all"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((request) => Request.fromJson(request))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> createReport(RequestDTO requestDTO) async {
    print('Api Post, url /v1/api/request/create');
    String token = await Auth().getToken();
    var responseJson;
    try {
      final response =
      await http.post(Uri.parse(Api.authUrl + "/v1/api/request/create"),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "requestTypeId": requestDTO.requestTypeId,
            "description": requestDTO.description
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