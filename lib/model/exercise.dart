class Exercise {
  int? id;
  String? name;
  String? thumbnail;
  bool isCheck = false;

  Exercise({this.id, this.name, this.thumbnail});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as int?,
      name: json['name'] as String?,
      thumbnail: json['thumbnail'] as String?);
}
