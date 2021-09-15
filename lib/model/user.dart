class User{
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

  User({this.username, this.password});

  factory User.fromMap(Map<String, dynamic> json) => User(
      username: json["username"],
      password: json["password"]);

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password
  };
}