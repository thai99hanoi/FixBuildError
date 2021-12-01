import 'package:heath_care/model/district.dart';
import 'package:heath_care/model/province.dart';
import 'package:heath_care/model/role.dart';
import 'package:heath_care/model/village.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int? userId;
  int? roleId;
  Village? village;
  District? district;
  Province? province;
  String? username;
  String? password;
  DateTime? lastLogin;
  String? email;
  String? phone;
  String? identityId;
  String? firstname;
  String? surname;
  String? lastname;
  String? address;
  String? avatar;
  String? gender;
  DateTime? dateOfBirth;
  int? isActive;
  int? isOnline;

  User(
      {this.userId,
      this.roleId,
      this.village,
      this.district,
      this.province,
      this.username,
      this.password,
      this.lastLogin,
      this.email,
      this.phone,
      this.identityId,
      this.firstname,
      this.surname,
      this.lastname,
      this.address,
      this.avatar,
      this.gender,
      this.dateOfBirth,
      this.isOnline,
      this.isActive});

  Map<String, dynamic> toMap() => {"username": username, "password": password};

  factory User.fromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as int?,
      roleId: json['role']['roleId'] as int?,
      village: Village.fromJson(json['village']),
      district: District.fromJson(json['village']["district"]),
      province: Province.fromJson(json['village']["district"]['province']),
      username: json['username'] as String?,
      password: json['password'] as String?,
      lastLogin: json['lastLogin'] != null ? DateTime?.parse(json["lastLogin"]) : json['lastLogin'] as DateTime?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      identityId: json['identityCard'] as String?,
      firstname: json["firstname"] as String?,
      surname: json["surname"] as String?,
      lastname: json["lastname"] as String?,
      address: json["address"] as String?,
      gender: json["gender"] as String?,
      dateOfBirth: json["dateOfBirth"] != null ? DateTime?.parse(json["dateOfBirth"]) : json['dateOfBirth'] as DateTime?,
      avatar: json["avatar"] as String?,
      isActive: json['isActive'] as int?,
      isOnline: json['isOnline'] as int?);

  String getLastName() {
    if (lastname != null && lastname!.isNotEmpty) {
      return lastname.toString();
    }
    return username.toString();
  }

  String getDisplayName() {
    if (firstname != null &&
        lastname != null &&
        firstname!.isNotEmpty &&
        lastname!.isNotEmpty) {
      return lastname.toString() + " ${surname ?? ""} " + firstname.toString();
    }
    return username.toString();
  }
}
