class ExerciseDetail {
  int? exerciseDetailId;
  int? exerciseId;
  String? description;
  String? imageDescription;

  ExerciseDetail({this.exerciseDetailId, this.exerciseId, this.description, this.imageDescription});

  factory ExerciseDetail.fromJson(Map<String, dynamic> json) => ExerciseDetail(
      exerciseDetailId: json['exerciseDetailId'] as int?,
      exerciseId: json['exerciseId'] as int?,
      description: json['description'] as String?,
      imageDescription: json['imageDescription'] as String?);
}