import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/model/user.dart';

class SymptomReport{
  int? id;
  User? user;
  Symptom? symptom;
  DateTime? date;
  String? time;

  SymptomReport({this.id, this.user, this.symptom, this.date, this.time});

  factory SymptomReport.fromJson(Map<String, dynamic> json) => SymptomReport(
      id: json['id'] as int?,
      user: User.fromJson(json['user']),
      symptom: Symptom.fromJson(json['symptom']),
      date: DateTime?.parse(json["date"]),
      time: json['time'] as String?);
}