class Province{
  int? provinceId;
  String? name;
  int? isActive;
  Province({this.provinceId, this.name, this.isActive});

  factory Province.fromJson(Map<String, dynamic> json) =>Province(
    provinceId: json['provinceId'] as int?,
    name: json['name'] as String?,
    isActive: json['isActive'] as int?
  );
}