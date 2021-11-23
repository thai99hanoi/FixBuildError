class DoctorByPatientDTO {
  int? patientId;
  int? userId;
  String? firstname;
  String? surname;
  String? lastname;
  String? email;
  String? phone;
  String? villageName;
  String? districtName;
  String? provinceName;
  String? hospitalName;

  DoctorByPatientDTO(
      {this.patientId,
      this.userId,
      this.firstname,
      this.surname,
      this.lastname,
      this.email,
      this.phone,
      this.villageName,
      this.districtName,
      this.provinceName,
      this.hospitalName});

  factory DoctorByPatientDTO.fromJson(Map<String, dynamic> json) =>
      DoctorByPatientDTO(
          patientId: json['patientId'] as int?,
          userId: json['userId'] as int?,
          firstname: json["firstname"] as String?,
          surname: json["surname"] as String?,
          lastname: json["lastname"] as String?,
          email: json['email'] as String?,
          phone: json['phone'] as String?,
          villageName: json['villageName'] as String?,
          districtName: json['districtName'] as String?,
          provinceName: json['provinceName'] as String?,
          hospitalName: json['hospitalName'] as String?);
}
