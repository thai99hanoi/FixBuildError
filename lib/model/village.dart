import 'package:heath_care/model/district.dart';

class Village{
  int? villageId;
  String? name;
  District? district;
  int? isActive;

  Village({this.villageId, this.name, this.district, this.isActive});

  factory Village.fromJson(Map<String, dynamic> json) => Village(
    villageId: json['villageId'] as int?,
    name: json['name'] as String?,
    district: District.fromJson(json['district']),
    isActive: json['isActive'] as int?
  );
}