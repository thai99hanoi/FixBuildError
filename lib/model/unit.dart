import 'package:heath_care/model/village.dart';

class Unit{
  int? unitId;
  String? name;
  String? address;
  Village? village;
  int? isActive;

  Unit({this.unitId, this.name, this.address, this.village, this.isActive});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    unitId: json['unitId'] as int?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    village: Village.fromJson(json['village']),
    isActive: json['isActive'] as int?
  );

}