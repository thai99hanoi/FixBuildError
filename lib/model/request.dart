import 'package:heath_care/model/request_type.dart';
import 'package:heath_care/model/user.dart';

class Request {
  int? id;
  User? user;
  RequestType? requestType;
  String? description;
  String? note;
  int? status;

  Request(
      {this.id,
      this.user,
      this.requestType,
      this.description,
      this.note,
      this.status});

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json['id'] as int?,
        user: User.fromJson(json['user']),
        requestType: RequestType.fromJson(json['requestType']),
        description: json['description'] as String?,
        note: json['note'] as String?,
        status: json['status'] as int?,
      );
}
