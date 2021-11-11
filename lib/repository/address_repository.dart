import 'dart:convert';
import 'dart:io';

import 'package:heath_care/model/district.dart';
import 'package:heath_care/model/province.dart';
import 'package:heath_care/model/village.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/utils/api.dart';
import 'package:heath_care/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;
class AddressRepository{
  Future<List<Province>?> getAllProvince() async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/province/get-all');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/province/get-all"),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((province) => Province.fromJson(province))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<District>?> getAllDistrictByProvinceId(int? provinceId) async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/district/get-all');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/district/get-all?provinceId="+ provinceId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((district) => District.fromJson(district))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<List<Village>?> getAllVillageByDistrictId(int? districtId) async {
    String? token = await Auth().getToken();
    print('Api Get, url /v1/api/village/get-all');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Api.authUrl + "/v1/api/village/get-all?districtId="+ districtId.toString()),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      print('api get recieved!');
      return (responseJson['data'] as List)
          .map((village) => Village.fromJson(village))
          .toList();
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}