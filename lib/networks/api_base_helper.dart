import 'dart:io';
import 'package:heath_care/networks/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:heath_care/utils/api.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    String? token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + url),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    String? token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.post(Uri.parse(Api.authUrl + url),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    String? token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.put(Uri.parse(Api.authUrl + url),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    String? token = await Auth().getToken();
    var apiResponse;
    try {
      final response = await http.delete(
        Uri.parse(Api.authUrl + url),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
