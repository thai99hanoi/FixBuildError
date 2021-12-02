class Report {
  int? dailyReportId;
  int? userId;
  String? firstname;
  String? surname;
  String? lastname;
  String? date;
  String? time;
  double? temperature;
  double? oxygen;
  List<dynamic>? medicines;
  List<dynamic>? symptoms;
  List<dynamic>? exercises;
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
      date: json['date'] as String?,
      time: json['time'] as String?,
      temperature: json['temperature'] as double?,
      oxygen: json['oxygen'] as double?,
      comment: json['comment'] as String?,
      medicines: json['medicines'] as List<dynamic>?,
      symptoms: json['symptoms'] as List<dynamic>?,
      exercises: json['exercises'] as List<dynamic>?);
}
