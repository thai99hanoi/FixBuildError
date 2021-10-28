class CovidAnalysis {
  int? death, cases, recovered;

  CovidAnalysis({this.death, this.cases, this.recovered});

  factory CovidAnalysis.fromJson(Map<String, dynamic> json)=> CovidAnalysis (
    death: json['death'] as int?,
    cases: json['cases'] as int?,
    recovered: json['recovered'] as int?,
  );
}
