import 'package:heath_care/model/user.dart';

import 'medicine.dart';

class MedicineReport{
  int? id;
  User? user;
  Medicine? medicine;
  DateTime? date;
  String? time;

  MedicineReport({this.id, this.user, this.medicine, this.date, this.time});

  factory MedicineReport.fromJson(Map<String, dynamic> json) => MedicineReport(
      id: json['id'] as int?,
      user: User.fromJson(json['user']),
      medicine: Medicine.fromJson(json['medicine']),
      date: json['date'] != null
          ? DateTime?.parse(json["date"])
          : json['date'] as DateTime?,
      time: json['time'] as String?);
}