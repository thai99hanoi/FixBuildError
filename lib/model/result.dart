import 'package:heath_care/model/sample_type.dart';
import 'package:heath_care/model/unit.dart';
import 'package:heath_care/model/user.dart';

class Result {
  int? resultId;
  String? resultCode;
  User? user;
  String? unitName;
  int? numberTest;
  DateTime? startDate;
  DateTime? collectDate;
  DateTime? testDate;
  DateTime? receiveDate;
  SampleType? sampleType;
  int? status;
  int? testResult;
  String? comment;
  int? isActive;

  Result(
      {this.resultId,
      this.resultCode,
      this.user,
      this.unitName,
      this.numberTest,
      this.startDate,
      this.collectDate,
      this.testDate,
      this.receiveDate,
      this.sampleType,
      this.status,
      this.testResult,
      this.comment,
      this.isActive});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      resultId: json['resultId'] as int?,
      resultCode: json['resultCode'] as String?,
      user: User.fromJson(json['user']),
      unitName: json['unit'] as String?,
      numberTest: json['numberTest'] as int?,
      startDate: json["startDate"] != null ? DateTime?.parse(json["startDate"]) : json["startDate"] as DateTime?,
      collectDate: json["collectDate"] != null ? DateTime?.parse(json["collectDate"]) : json["collectDate"] as DateTime?,
      testDate: json["testDate"] != null ? DateTime?.parse(json["testDate"]) : json["testDate"] as DateTime?,
      receiveDate: json["receiveDate"] != null ? DateTime?.parse(json["receiveDate"]) : json["receiveDate"] as DateTime?,
      sampleType: SampleType.fromJson(json['sampleType']),
      status: json['status'] as int?,
      testResult: json['testResult'] as int?,
      comment: json['comment'] as String?,
      isActive: json['isActive'] as int?);

}
