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
      this.firstname,
      this.surname,
      this.lastname,
      this.address,
      this.avatar,
      this.isOnline,
      this.isActive});

  factory User.fromMap(Map<String, dynamic> json) => User(
      userId: json["userId"],
      roleId: json["roleId"],
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
      userId: json['userId'] as int,
      roleId: json['roleId'] as int,
      stationId: json['stationId'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      lastLogin: json['lastLogin'] as DateTime,
      email: json['email'] as String,
      phone: json['phone'] as String,
      identityId: json['identityId'] as String,
      firstname: json["firstname"] as String,
      surname: json["surname"] as String,
      lastname: json["lastname"] as String,
      address: json["address"] as String,
      avatar: json["avatar"] as String,
      isActive: json['isActive'] as String,
      isOnline: json['isOnline'] as String);
}
