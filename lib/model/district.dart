import 'package:heath_care/model/province.dart';

class District {
  int? districtId;
  String? name;
  Province? province;
  int? isActive;

  District({this.districtId, this.province, this.name, this.isActive});

  factory District.fromJson(Map<String, dynamic> json) => District(
    districtId: json['districtId'] as int?,
    name: json['name'] as String?,
    province: Province.fromJson(json['province']),
    isActive: json['isActive'] as int?
  );
}
