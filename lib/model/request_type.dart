class RequestType {
  int? id;
  String? requestTypeName;

  RequestType({this.id, this.requestTypeName});

  factory RequestType.fromJson(Map<String, dynamic> json) => RequestType(
      id: json['id'] as int?,
      requestTypeName: json['requestTypeName'] as String?);
}
