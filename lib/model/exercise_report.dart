import 'package:heath_care/model/exercise.dart';
import 'package:heath_care/model/user.dart';

class ExerciseReport {
  int? id;
  User? user;
  Exercise? exercise;
  DateTime? date;
  String? time;

  ExerciseReport({this.id, this.user, this.exercise, this.date, this.time});

  factory ExerciseReport.fromJson(Map<String, dynamic> json) => ExerciseReport(
      id: json['id'] as int?,
      user: User.fromJson(json['user']),
      exercise: Exercise.fromJson(json['exercise']),
      date: DateTime?.parse(json["date"]),
      time: json['time'] as String?);
}
