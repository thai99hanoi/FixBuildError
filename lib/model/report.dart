class Report {
  int? userId;
  String? firstname;
  String? surname;
  String? lastname;
  DateTime? date;
  String? time;
  double? temperature;
  double? oxygen;
  String? medicine;
  String? symptom;
  String? exercise;
  String? comment;

  Report(
      {this.userId,
      this.firstname,
      this.surname,
      this.lastname,
      this.date,
      this.time,
      this.temperature,
      this.oxygen,
      this.comment,
      this.symptom,
      this.exercise,
      this.medicine});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    userId: json['userId'] as int?,
    firstname: json["firstname"] as String?,
    surname: json["surname"] as String?,
    lastname: json["lastname"] as String?,
    date: json['dateReport'] != null
        ? DateTime?.parse(json["dateReport"])
        : json['dateReport'] as DateTime?,
    time: json['time'] as String?,
    temperature: json['temperature'] as double?,
    oxygen: json['oxygen'] as double?,
    comment: json['comment'] as String?,
    medicine: json['medicine'] as String?,
    symptom: json['symptom'] as String?,
    exercise: json['exercise'] as String?
  );
}
