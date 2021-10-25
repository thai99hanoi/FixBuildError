class Symptom {
  int? symptomId;
  String? name;
  String? description;
  int? isActive;
  bool isCheck = false;

  Symptom({
    this.symptomId,
    this.name,
    this.description,
    this.isActive,
  });

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
      symptomId: json['symptomId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      isActive: json['isActive'] as int);
}
