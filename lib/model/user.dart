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
  String? isActive;
  String? isOnline;

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

  factory User.fromJson(Map<String, dynamic> json) =>
      User(userId: json['userId'] as int,
          roleId: json['roleId'] as int,
          stationId: json['stationId'] as int,
          username: json['username'] as String,
          password: json['password'] as String,
          lastLogin: json['lastLogin'] as DateTime,
          email: json['email'] as String,
          phone: json['phone'] as String,
          identityId: json['identityId'] as String,
          isActive: json['isActive'] as String,
          isOnline: json['isOnline'] as String
      );
}
