import 'package:heath_care/model/daily_report.dart';
import 'package:heath_care/model/medicine_report.dart';
import 'package:heath_care/model/symptom_report.dart';
import 'exercise_report.dart';

class ListReportDTO {
  List<DailyReport>? listDailyReport;
  List<ExerciseReport>? listExerciseReport;
  List<SymptomReport>? listSymptomReport;
  List<MedicineReport>? listMedicineReport;

  ListReportDTO(
      {this.listDailyReport,
      this.listExerciseReport,
      this.listSymptomReport,
      this.listMedicineReport});

  factory ListReportDTO.fromJson(Map<String, dynamic> json) => ListReportDTO(
      listDailyReport: (json['listDailyReport'] as List).map((dailyReport) => DailyReport.fromJson(dailyReport)).toList() ,
      listExerciseReport: (json['listExerciseReport'] as List).map((exerciseReport) => ExerciseReport.fromJson(exerciseReport)).toList(),
      listSymptomReport: (json['listSymptomReport'] as List).map((symptomReport) => SymptomReport.fromJson(symptomReport)).toList(),
      listMedicineReport: (json['listMedicineReport'] as List).map((medicineReport) => MedicineReport.fromJson(medicineReport)).toList());
}
