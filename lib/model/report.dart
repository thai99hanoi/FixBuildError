class Report {
  int? dailyReportId;
  int? userId;
  String? firstname;
  String? surname;
  String? lastname;
  DateTime? date;
  String? time;
  double? temperature;
  double? oxygen;
  List<String>? medicines;
  List<String>? symptoms;
  List<String>? exercises;
  String? comment;

  Report(
      {this.dailyReportId,
        this.userId,
      this.firstname,
      this.surname,
      this.lastname,
      this.date,
      this.time,
      this.temperature,
      this.oxygen,
      this.comment,
      this.symptoms,
      this.exercises,
      this.medicines});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      dailyReportId: json['dailyReportId'] as int?,
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
    medicines: json['medicines'] as List<String>?,
    symptoms: json['symptoms'] as List<String>?,
    exercises: json['exercises'] as List<String>?
  );
}
