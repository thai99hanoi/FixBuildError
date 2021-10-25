import 'package:heath_care/model/role.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int? userId;
  int? roleId;
  int? stationId;
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
  int? isActive;
  int? isOnline;

  User(
      {this.userId,
      this.roleId,
      this.stationId,
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
      this.isOnline,
      this.isActive});

  factory User.fromMap(Map<String, dynamic> json) => User(
      userId: json["userId"],
      roleId: json['role']['roleId'] as int?,
      stationId: json["stationId"],
      username: json["username"],
      password: json["password"],
      lastLogin: json["lastLogin"],
      email: json["email"],
      phone: json["phone"],
      identityId: json["identityId"],
      firstname: json["firstname"],
      surname: json["surname"],
      lastname: json["lastname"],
      address: json["address"],
      avatar: json["avatar"],
      isActive: json["isActive"],
      isOnline: json["isOnline"]);

  Map<String, dynamic> toMap() => {"username": username, "password": password};

  factory User.fromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as int?,
      roleId: json['role']['roleId'] as int?,
      stationId: json['stationId'] as int?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      lastLogin: json['lastLogin'] as DateTime?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      identityId: json['identityId'] as String?,
      firstname: json["firstname"] as String?,
      surname: json["surname"] as String?,
      lastname: json["lastname"] as String?,
      address: json["address"] as String?,
      avatar: json["avatar"] as String?,
      isActive: json['isActive'] as int?,
      isOnline: json['isOnline'] as int?);

  String getLastName() {
    if(lastname != null && lastname!.isNotEmpty){
      return lastname.toString();
    }
    return username.toString();
  }

  String getDisplayName() {
    if (firstname != null &&
        lastname != null &&
        firstname!.isNotEmpty &&
        lastname!.isNotEmpty) {
      return firstname.toString() + " ${surname ?? ""} " + lastname.toString();
    }
    return username.toString();
  }
}

