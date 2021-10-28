import 'package:heath_care/model/covid_analysis.dart';
import 'package:heath_care/networks/api_base_helper.dart';

class CovidAnalysisRepository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<CovidAnalysis> getCurrentPatients() async {
    final response = await apiBaseHelper.getCovidInfo();
    CovidAnalysis _currentPatients = CovidAnalysis.fromJson(response['total']['internal']);
    return _currentPatients;
  }

  Future<CovidAnalysis> getTodayPatients() async {
    final response = await apiBaseHelper.getCovidInfo();
    CovidAnalysis _todayPatients = CovidAnalysis.fromJson(response['today']['internal']);
    return _todayPatients;
  }
}
