class DailyCheckDTO {
  int? dailyReportId;
  int? userId;
  String? username;
  String? firstname;
  String? surname;
  String? lastname;
  String? email;
  String? phone;
  String? gender;
  String? villageName;
  String? districtName;
  String? provinceName;
  DateTime? date;
  String? time;
  double? temperature;
  double? oxygen;
  String? comment;
  int? isActive;

  DailyCheckDTO(
      {this.dailyReportId,
      this.userId,
      this.username,
      this.firstname,
      this.surname,
      this.lastname,
      this.email,
      this.phone,
      this.gender,
      this.villageName,
      this.districtName,
      this.provinceName,
      this.date,
      this.time,
      this.temperature,
      this.oxygen,
      this.comment,
      this.isActive});

  factory DailyCheckDTO.fromJson(Map<String, dynamic> json) => DailyCheckDTO(
        dailyReportId: json['dailyReportId'] as int?,
        userId: json['userId'] as int?,
        username: json["username"] as String?,
        firstname: json["firstname"] as String?,
        surname: json["surname"] as String?,
        lastname: json["lastname"] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        gender: json['gender'] as String?,
        villageName: json['villageName'] as String?,
        districtName: json['districtName'] as String?,
        provinceName: json['provinceName'] as String?,
        date: json['dateReport'] != null
            ? DateTime?.parse(json["dateReport"])
            : json['dateReport'] as DateTime?,
        time: json['time'] as String?,
        temperature: json['temperature'] as double?,
        oxygen: json['oxygen'] as double?,
        comment: json['comment'] as String?,
        isActive: json['isActive'] as int?,
      );
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
