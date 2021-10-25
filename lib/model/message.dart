import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String from;
  String? content;
  Timestamp createdTime;

  Message(this.from, this.content, this.createdTime);

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      json['userName'] as String,
      json['content'] as String,
      json['created_time']);

  Map toMap() => new Map<String, dynamic>.from({
    "from": this.from,
    "created_time": this.createdTime,
    "content": this.content,
  });
}