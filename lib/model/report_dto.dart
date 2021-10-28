class ReportDTO {
  String? username;
  String? firstname;
  String? surname;
  String? lastname;
  String? oxygen;
  String? temprate;
  int? symptomId;
  String? comment;
  int? exerciseId;
  int? medicineId;

  ReportDTO(
      {this.username,
      this.surname,
      this.firstname,
      this.lastname,
      this.oxygen,
      this.temprate,
      this.comment,
      this.symptomId,
      this.exerciseId,
      this.medicineId});

  factory ReportDTO.fromJson(Map<String, dynamic> json) => ReportDTO(
        username: json['username'] as String?,
        surname: json['surname'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        oxygen: json['oxygen'] as String?,
        temprate: json['temprate'] as String?,
        symptomId: json['symptomId'] as int?,
        comment: json['comment'] as String?,
        exerciseId: json['exerciseId'] as int?,
        medicineId: json['medicineId'] as int?,
      );
}
