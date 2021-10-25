import 'package:cloud_firestore/cloud_firestore.dart';

class RequestCall {
  String from;
  String? fullNameFrom;
  String chatId;
  String? avatarFrom;
  String? roomId;
  List<String> participants;
  bool completed;

  bool isVoiceCall;
  bool inComingCall;

  RequestCall(this.from, this.chatId, this.participants,
      {this.fullNameFrom,
        this.avatarFrom,
        this.roomId,
        this.completed = false,
        this.isVoiceCall = false,
        this.inComingCall = true});

  factory RequestCall.fromJson(Map<String, dynamic> json) => RequestCall(
      json['from'],
      json['chat_id'],
      (json['participants'] as List).map((e) => e.toString()).toList(),
      fullNameFrom: json['full_name_from'],
      avatarFrom: json['avatar_from'],
      roomId: json['room_id'],
      completed: json['completed'],
      isVoiceCall: json['is_voice_call'],
      inComingCall: json['incoming_call']);

  Map toMap() => new Map<String, dynamic>.from({
    "from": this.from,
    "chat_id": this.chatId,
    "participants": this.participants,
    "full_name_from": this.fullNameFrom,
    "avatar_from": this.avatarFrom,
    "room_id": this.roomId,
    "completed": this.completed,
    "is_voice_call": this.isVoiceCall,
    "incoming_call": this.inComingCall,
  });
}