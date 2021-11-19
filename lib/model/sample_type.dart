class SampleType {
  int? typeId;
  String? name;
  int? isActive;

  SampleType({this.typeId, this.name, this.isActive});

  factory SampleType.fromJson(Map<String, dynamic> json) => SampleType(
      typeId: json['typeId'] as int?,
      name: json['name'] as String?,
      isActive: json['isActive'] as int?
  );
}
