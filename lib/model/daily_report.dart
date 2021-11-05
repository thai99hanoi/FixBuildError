class DailyReport {
  int? dailyReportId;
  int? userId;
  DateTime? date;
  String? time;
  double? temperature;
  double? oxygen;
  String? comment;
  int? isActive;

  DailyReport(
      {this.dailyReportId,
      this.userId,
      this.date,
      this.time,
      this.temperature,
      this.oxygen,
      this.comment,
      this.isActive});

  factory DailyReport.fromJson(Map<String, dynamic> json)=> DailyReport(
    dailyReportId: json['dailyReportId'] as int?,
    userId: json['user']['userId'] as int?,
    date: json['date'] as DateTime?,
    time: json['time'] as String?,
    temperature: json['temperature'] as double?,
    oxygen: json['oxygen'] as double?,
    isActive: json['isActive'] as int?
  );
}
