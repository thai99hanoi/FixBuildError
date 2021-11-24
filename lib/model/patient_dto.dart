class PatientDTO {
  int? patientId;
  int? userId;
  String? firstname;
  String? surname;
  String? lastname;
  String? username;
  String? email;
  String? phone;
  String? villageName;
  String? districtName;
  String? provinceName;

  PatientDTO(
      {this.patientId,
      this.userId,
      this.firstname,
      this.surname,
      this.lastname,
      this.username,
      this.email,
      this.phone,
      this.villageName,
      this.districtName,
      this.provinceName});

  factory PatientDTO.fromJson(Map<String, dynamic> json) => PatientDTO(
        patientId: json['patientId'] as int?,
        userId: json['userId'] as int?,
        firstname: json["firstname"] as String?,
        surname: json["surname"] as String?,
        lastname: json["lastname"] as String?,
        username: json["username"] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        villageName: json['villageName'] as String?,
        districtName: json['districtName'] as String?,
        provinceName: json['provinceName'] as String?,
      );
}
