class Role {
  int? roleId;
  String? description;
  int? isActive;

  Role({this.roleId, this.description, this.isActive});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    roleId: json['roleId'] as int?,
    description: json['description'] as String?,
    isActive: json['isActive'] as int?
  );
}
