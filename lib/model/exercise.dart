class Exercise {
  int? id;
  String? name;
  String? thumbnail;
  String? description;
  bool isCheck = false;

  Exercise({this.id, this.name, this.description, this.thumbnail});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?);
}
