class CovidAnalysis {
  int? death, cases, treating, recovered;

  CovidAnalysis({this.death, this.cases, this.treating, this.recovered});

  factory CovidAnalysis.fromJson(Map<String, dynamic> json)=> CovidAnalysis (
    death: json['death'] as int?,
    cases: json['cases'] as int?,
    treating: json['cases'] as int?,
    recovered: json['recovered'] as int?,
  );
}
