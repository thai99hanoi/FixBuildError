class ReportDTO {
  String? username;
  String? firstname;
  String? surname;
  String? lastname;
  String? oxygen;
  String? temperate;
  List<int?>? symptomId;
  String? comment;
  List<int?>? exerciseId;
  List<int?>? medicineId;

  ReportDTO(
      {this.username,
      this.surname,
      this.firstname,
      this.lastname,
      this.oxygen,
      this.temperate,
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
        temperate: json['temperate'] as String?,
        symptomId: json['symptomId'] as List<int?>?,
        comment: json['comment'] as String?,
        exerciseId: json['exerciseId'] as List<int?>?,
        medicineId: json['medicineId'] as List<int?>?,
      );
}
