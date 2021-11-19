import 'package:heath_care/model/sample_type.dart';
import 'package:heath_care/model/unit.dart';
import 'package:heath_care/model/user.dart';

class Result {
  int? resultId;
  String? resultCode;
  User? user;
  Unit? unit;
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
      this.unit,
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
      unit: Unit.fromJson(json['unit']),
      numberTest: json['numberTest'],
      startDate: DateTime?.parse(json["startDate"]),
      collectDate: DateTime?.parse(json["collectDate"]),
      testDate: DateTime?.parse(json["testDate"]),
      receiveDate: DateTime?.parse(json["receiveDate"]),
      sampleType: SampleType.fromJson(json['sampleType']),
      status: json['status'] as int?,
      testResult: json['testResult'] as int?,
      comment: json['comment'] as String?,
      isActive: json['isActive'] as int?);

}
