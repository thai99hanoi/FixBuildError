import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:heath_care/utils/api.dart';

class ApiBaseHelper {
  int _timeOut = 10000; //10 s
  late Dio _dio;
  DioCacheManager? _dioCacheManager;

  DioCacheManager get dioCacheManager {
    _dioCacheManager ??= DioCacheManager(CacheConfig(baseUrl: Api.authUrl));
    return _dioCacheManager!;
  }

  ApiBaseHelper() {
    BaseOptions options =
    BaseOptions(connectTimeout: _timeOut, receiveTimeout: _timeOut);
    options.baseUrl = Api.authUrl;
    _dio = Dio(options);
    // _dio.interceptors
    //     .add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.interceptors.add(dioCacheManager.interceptor);
  }

  Future<dynamic> getWithCache(String url,
      {Map<String, dynamic>? params, Options? options}) async {
    params ??= {};
    options ??= buildCacheOptions(Duration(minutes: 30),
        maxStale: Duration(minutes: 30));
    print('Api Get, url $url');
    String token = await Auth().getToken();
    print('token $token');
    var responseJson;
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["authorization"] = "Bearer $token";
      final response = await _dio.get(Api.authUrl + url,
          queryParameters: params, options: options);

      responseJson =
          _returnResponse(response.statusCode ?? 0, json.encode(response.data));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> getCovidInfo(
      {Map<String, dynamic>? params, Options? options}) async {
    params ??= {};
    options ??= buildCacheOptions(Duration(minutes: 30),
        maxStale: Duration(minutes: 30));
    print('Api Get, url https://static.pipezero.com/covid/data.json');
    String token = await Auth().getToken();
    print('token $token');
    var responseJson;
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      final response = await _dio.get("https://static.pipezero.com/covid/data.json",
          queryParameters: params, options: options);

      responseJson =
          _returnResponse(response.statusCode ?? 0, json.encode(response.data));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }



  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    String token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + url),
        headers: {
          "content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 10));
      responseJson =
          _returnResponse(response.statusCode, json.encode(utf8.decode(response.bodyBytes)));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    String token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.post(Uri.parse(Api.authUrl + url),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: body);
      responseJson =
          _returnResponse(response.statusCode, json.encode(response.body));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    String token = await Auth().getToken();
    var responseJson;
    try {
      final response = await http.put(Uri.parse(Api.authUrl + url),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: body);
      responseJson =
          _returnResponse(response.statusCode, json.encode(response.body));
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
    String token = await Auth().getToken();
    var apiResponse;
    try {
      final response = await http.delete(
        Uri.parse(Api.authUrl + url),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      apiResponse =
          _returnResponse(response.statusCode, json.encode(response.body));
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(int statusCode, String body) {
  switch (statusCode) {
    case 200:
      var responseJson = json.decode(body);
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(body);
    case 401:
    case 403:
      throw UnauthorisedException(body);
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${statusCode}');
  }
}