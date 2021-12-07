class Medicine {
  int? id;
  String? name;
  String? description;
  String? detail;
  String? thumbnail;
  bool isCheck = false;

  Medicine({this.id, this.name, this.description, this.detail, this.thumbnail});

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      detail: json['detail'] as String?,
      thumbnail: json['thumbnail'] as String?);
}
