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
  bool? isActive;
  bool? isOnline;

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
      this.isOnline,
      this.isActive});

  factory User.fromMap(Map<String, dynamic> json) =>
      User(userId: json["userId"],
          roleId: json["roleId"],
          stationId: json["stationId"],
          username: json["username"],
          password: json["password"],
          lastLogin: json["lastLogin"],
          email: json["email"],
          phone: json["phone"],
          identityId: json["identityId"],
          isActive: json["isActive"],
          isOnline: json["isOnline"]
      );

  Map<String, dynamic> toMap() => {"username": username, "password": password};
}
